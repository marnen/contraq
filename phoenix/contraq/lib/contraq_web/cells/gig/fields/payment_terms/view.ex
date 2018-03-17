defmodule ContraqWeb.Gig.Fields.PaymentTermsCell do
  use ContraqWeb, :cell
  alias Contraq.Gigs.Gig

  @spec due_date(%Gig{terms: nil}) :: nil
  @spec due_date(%Gig{}) :: String.t
  defp due_date(%Gig{terms: nil}), do: nil
  defp due_date(%Gig{terms: terms, start_time: start_time}) do
    Timex.shift(start_time, days: terms) |> Timex.format!(Application.get_env(:contraq, ContraqWeb)[:date_format])
  end
end
