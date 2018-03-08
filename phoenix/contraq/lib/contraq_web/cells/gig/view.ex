defmodule ContraqWeb.GigCell do
  use ContraqWeb, :cell
  alias ContraqWeb.Endpoint
  alias Contraq.Gigs.Gig
  alias Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]

  @spec container(%Gig{}) :: HTML.safe
  def container!(%Gig{id: id}, do: content) do
    container tag: :article, id: "gig-#{id}" do
      content
    end
  end

  # TODO: Some of these seem like they belong elsewhere, but where? On Gig? On Gigs (the context)? On a helper module? GigView, maybe?
  @spec location(%Gig{}) :: String.t
  def location(%Gig{city: city, state: state}) do
    [city, state] |> Enum.reject(&is_nil/1) |> Enum.join(", ")
  end

  @spec time_range(%Gig{}) :: String.t
  def time_range(%Gig{start_time: start_time, end_time: end_time}) do
    (for time <- [start_time, end_time], do: Timex.format!(time, Application.get_env(:contraq, ContraqWeb)[:datetime_format])) |> Enum.join("–")
  end

  @spec dasherize(atom | String.t) :: String.t
  defp dasherize(string) do
    string |> to_string |> String.replace("_", "-")
  end

  @spec fields :: [atom]
  defp fields do
    [:time_range, :location]
  end

  @spec link_to(%Gig{}) :: HTML.safe
  defp link_to(%Gig{name: name} = gig) do
    link name, to: gig_path(Endpoint, :show, gig)
  end

  @impl ExCell.Cell
  def class_name do
    "gig"
  end
end
