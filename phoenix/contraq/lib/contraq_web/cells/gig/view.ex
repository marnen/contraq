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

  @spec payment_terms(%Gig{}) :: HTML.safe
  defp payment_terms(%Gig{} = gig) do
    import Enum, only: [intersperse: 2]
    import Map, only: [get: 2]
    import HTML, only: [html_escape: 1]
    import HTML.Tag, only: [content_tag: 3]

    class_mappings = %{amount_due: :amount_due, formatted_terms: :terms}

    for key <- [:amount_due, :formatted_terms], value = get(gig, key) do
      content_tag :span, value, class: class_for(class_mappings[key])
    end |> intersperse(html_escape ", ")
  end

  @impl ExCell.Cell
  def class_name do
    "gig"
  end
end
