defmodule ContraqWeb.GigCell do
  use ContraqWeb, :cell
  alias ContraqWeb.Endpoint
  alias Contraq.Gigs.Gig
  alias Phoenix.HTML
  import Phoenix.HTML.Link, only: [link: 2]

  @spec container!(%Gig{}, do: HTML.safe) :: HTML.safe
  def container!(%Gig{id: id}, do: content) do
    container tag: :article, id: "gig-#{id}" do
      content
    end
  end

  @spec dasherize(atom | String.t) :: String.t
  defp dasherize(string) do
    string |> to_string |> String.replace("_", "-")
  end

  @spec field(%Gig{}, atom) :: String.t
  defp field(%Gig{} = gig, name) do
    apply(ContraqWeb.GigView, name, [gig])
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
