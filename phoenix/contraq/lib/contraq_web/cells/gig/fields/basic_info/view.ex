defmodule ContraqWeb.Gig.Fields.BasicInfoCell do
  use ContraqWeb, :cell

  @fields [
    start_time: gettext("Start time:"),
    end_time: gettext("End time:"),
    location: gettext("Location:")
  ]

  @spec fields :: keyword(String.t)
  defp fields, do: @fields
end
