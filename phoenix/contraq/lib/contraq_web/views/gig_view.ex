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
end
