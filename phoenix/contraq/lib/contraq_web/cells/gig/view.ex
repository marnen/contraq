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

  @spec class_for(atom | String.t) :: String.t
  defp class_for(field_name) do
    field_name |> to_string |> Contraq.Naming.dasherize
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
