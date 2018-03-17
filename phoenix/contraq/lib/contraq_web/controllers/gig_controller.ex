defmodule ContraqWeb.GigController do
  use ContraqWeb, :controller

  alias Contraq.Gigs
  alias Contraq.Gigs.Gig
  alias Plug.Conn

  import Coherence, only: [current_user: 1]

  plug :load_gig! when action not in [:index, :new, :create]
  plug :authorize! when action not in [:index, :new, :create]

  def index(conn, _params) do
    gigs = Gigs.list_gigs(user: current_user conn) |> Enum.map(&Gig.decorate/1)
    render(conn, "index.html", gigs: gigs, page_title: _("Gigs"))
  end

  def new(conn, _params) do
    changeset = Gigs.change_gig(%Gig{})
    render(conn, "new.html", changeset: changeset, page_title: _("Create Gig"))
  end

  def create(conn, %{"gig" => gig_params}) do
    case Gigs.create_gig(Map.merge gig_params, %{"user" => current_user(conn)}) do
      {:ok, gig} ->
        conn
        |> put_flash(:info, "Gig created successfully.")
        |> redirect(to: gig_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, page_title: _("Create Gig"))
    end
  end

  def show(conn, %{"id" => id}) do
    gig = Gigs.get_gig!(id) |> Gig.decorate
    render(conn, "show.html", gig: gig, page_title: gig.name, header_class: :name)
  end

  def edit(%Conn{assigns: assigns} = conn, %{"id" => id}) do
    gig = assigns.gig
    changeset = Gigs.change_gig(gig)
    render conn, "edit.html", assigns |> Map.merge(%{changeset: changeset, page_title: _(~s(Edit Gig "%{gig}"), gig: gig.name)})
  end

  def update(conn, %{"id" => id, "gig" => gig_params}) do
    gig = Gigs.get_gig!(id)

    case Gigs.update_gig(gig, Map.merge(gig_params, %{"user" => current_user(conn)})) do
      {:ok, gig} ->
        conn
        |> put_flash(:info, "Gig updated successfully.")
        |> redirect(to: gig_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gig: gig, changeset: changeset, page_title: _(~s(Edit Gig "%{gig}"), gig: gig.name))
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   gig = Gigs.get_gig!(id)
  #   {:ok, _gig} = Gigs.delete_gig(gig)
  #
  #   conn
  #   |> put_flash(:info, "Gig deleted successfully.")
  #   |> redirect(to: gig_path(conn, :index))
  # end

  defp authorize!(conn, _opts) do
    permission = case action_name(conn) do
      :update -> :edit
      other -> other
    end
    case Bodyguard.permit Contraq.Gigs, permission, current_user(conn), conn.assigns.gig do
      :ok -> conn
      {:error, _} ->
        conn
        |> put_flash(:error, _("You are not authorized to perform that action."))
        |> redirect(to: back(conn) || gig_path(conn, :index)) # TODO: use FallbackController?
        |> halt
    end
  end

  @spec back(Conn.t) :: String.t | nil
  defp back(%Conn{req_headers: headers, host: host, port: port}) do
    header_map = Enum.into(headers, %{})
    referer = header_map["referer"]
    # GO
    if referer do
      parsed_referer = URI.parse(referer)
      if parsed_referer.host == host && parsed_referer.port == port do
        parsed_referer.path
      else
        nil
      end
    end
  end

  defp load_gig!(%Conn{params: %{"id" => id}} = conn, _opts) do
    gig = Gigs.get_gig! id
    Conn.assign conn, :gig, gig
  end
end
