defmodule GigSteps do
  use WhiteBread.Context
  use Wallaby.DSL
  alias Contraq.Repo
  alias Contraq.Gigs.Gig
  alias Contraq.Factory

  @time_format Application.get_env(:contraq, ContraqWeb)[:datetime_format]

  given_ "I have no gigs", fn state ->
    Repo.delete_all Gig
    {:ok, state}
  end

  given_ "I have the following gigs:", fn state, {:table_data, table_data} ->
    # TODO: should we use a changeset here?
    for gig <- table_data do
      attributes = for {key, value} <- gig, into: %{} do
        new_key = key |> to_string |> String.replace(~r{\s}, "_")
        {:ok, new_value} = if new_key |> String.ends_with?("_time") do
          Timex.parse value, @time_format
        else
          {:ok, value}
        end
        {String.to_atom(new_key), new_value}
      end
      Factory.insert! :gig, attributes
    end
    {:ok, state}
  end

  then_ "I should see the following gigs:", fn %{session: session} = state, {:table_data, table_data} ->
    for fields <- table_data do
      # TODO: refactor this mess! It was translated from some already bad Ruby code; it still needs work. :)

      {special_fields, other_fields} = Map.split(fields, [:name, :start_time, :end_time])
      %{}
      time_range = Enum.reject([special_fields[:start_time], special_fields[:end_time]], &is_nil/1) |> Enum.join("–")
      other_fields_selector = (for {_, value} <- other_fields, do: "[contains(normalize-space(.), '#{value}')]") |> Enum.join

      class_mappings = %{
        "name" => special_fields[:name],
        "time-range" => time_range
      }
      selector = [
        "//*[@class='gig']#{other_fields_selector}" |
        for {class_name, text} <- class_mappings, String.length(String.trim text) > 0 do
          "[#{xpath class_name: class_name, text: text}]"
        end
      ] |> Enum.join
      assert session |> has?(Query.xpath selector)
    end
    {:ok, state}
  end

  defp xpath(class_name: class_name, text: text) do
    "//*[@class='#{class_name}'][contains(normalize-space(.), '#{text}')]"
  end
end
