defmodule ContraqWeb.GigView do
  @dialyzer :no_return
  use ContraqWeb, :view
  alias Contraq.Gigs.Gig

  @spec location(%Gig{}) :: String.t
  def location(%Gig{city: city, state: state}) do
    [city, state] |> Enum.reject(&is_nil/1) |> Enum.join(", ")
  end

  @spec time_range(%Gig{}) :: String.t
  def time_range(%Gig{start_time: start_time, end_time: end_time}) do
    for time <- [start_time, end_time] do
      Timex.format!(time, Application.get_env(:contraq, ContraqWeb)[:datetime_format])
    end |> Enum.join("–")
  end

  @spec formatted_terms(%Gig{terms: nil}) :: nil
  def formatted_terms(%Gig{terms: nil}), do: nil
  @spec formatted_terms(%Gig{terms: integer}) :: String.t
  def formatted_terms(%Gig{terms: terms} = gig) do
    ngettext("%{days} day (%{due_date})", "%{days} days (%{due_date})", terms, days: terms, due_date: due_date gig)
  end

  @spec due_date(%Gig{terms: integer}) :: String.t
  defp due_date(%Gig{terms: terms, start_time: start_time}) do
    Timex.shift(start_time, days: terms)
    |> Timex.format!(Application.get_env(:contraq, ContraqWeb)[:date_format])
  end
end
