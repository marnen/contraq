defmodule ContraqWeb.OutputFieldCell do
  use ContraqWeb, :cell
  alias Contraq.Gigs.Gig

  @spec container!(map, do: HTML.safe) :: HTML.safe
  def container!(assigns, do: content) do
    container class: class_name(assigns) do
      content
    end
  end

  @spec class_name(%{field: String.t | atom}) :: String.t
  defp class_name(%{field: field}) do
    field |> to_string |> Contraq.Naming.dasherize
  end

  @spec property(%Gig{}, atom) :: any
  defp property(%Gig{} = gig, field) do
    value = Map.get gig, field
    if !match?(%Decimal{}, value) && Timex.is_valid? value do
      Timex.format! value, Application.get_env(:contraq, ContraqWeb)[:datetime_format]
    else
      value
    end
  end
end