defmodule ContraqWeb.Gig.Fields.PaymentTermsCell do
  use ContraqWeb, :cell
  alias Contraq.Gigs.Gig

  @spec due_date(%Gig{terms: nil}) :: nil
  @spec due_date(%Gig{}) :: String.t
  defp due_date(%Gig{terms: nil}), do: nil
  defp due_date(%Gig{terms: terms, start_time: start_time}) do
    Timex.shift(start_time, days: terms) |> Timex.format!(Application.get_env(:contraq, ContraqWeb)[:date_format])
  end

  @spec terms(%Gig{terms: nil}) :: nil
  @spec terms(%Gig{}) :: String.t
  defp terms(%Gig{terms: nil}), do: nil
  defp terms(%Gig{terms: terms}), do: ngettext("%{days} day", "%{days} days", terms, days: terms)
end
