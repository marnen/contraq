defmodule GigSteps do
  use WhiteBread.Context, test_library: :espec
  use Wallaby.DSL
  alias Contraq.Repo
  alias Contraq.Gigs.Gig
  alias Contraq.Coherence.User
  alias Contraq.Factory

  @time_format Application.get_env(:contraq, ContraqWeb)[:datetime_format]
  @time_format_fallback "{ISOdate} {h24}:{m}"

  given_ "a gig exists", fn state ->
    gig = Factory.insert! :gig
    {:ok, state |> put_in([:gig], gig)}
  end

  given_ "I have a gig", fn %{current_user: current_user} = state ->
    gig = Factory.insert! :gig, %{user: current_user}
    {:ok, state |> put_in([:gig], gig)}
  end

  given_ "I have no gigs", fn state ->
    Repo.delete_all Gig
    {:ok, state}
  end

  given_ ~r/^I have the following gigs?:$/,
  fn %{current_user: %User{} = current_user} = state, %{table_data: table_data} ->
    # TODO: should we use a changeset here?
    for row <- table_data, do: Factory.insert! :gig, gig_attributes(row) |> Map.merge(%{user: current_user})
    {:ok, state}
  end

  given_ "the following gigs exist:", fn state, {:table_data, table_data} ->
    for row <- table_data do
      attributes = gig_attributes(row) |> Map.merge(%{user: Contraq.Coherence.Schemas.get_user_by_email(row[:user])})
      Factory.insert! :gig, attributes
    end
    {:ok, state}
  end

  then_ ~r/^I should see a gig with name: "(?<name>[^"]+)"$/,
  fn %{session: session} = state, %{name: name} ->
    # TODO: use selectors helper
    assert(session |> has?(Query.css ".gig .name", text: name))
    {:ok, state}
  end

  then_ ~r/^I should (?<negation>not )?see the following gigs?:$/,
  fn %{session: session} = state, %{negation: negation, table_data: table_data} ->
    import Enum, only: [join: 1, join: 2, reject: 2, map: 2]

    for fields <- table_data do
      # TODO: refactor this mess! It was translated from some already bad Ruby code; it still needs work. :)
      fields = atomize_keys(fields)
      {special_fields, other_fields} = Map.split(fields, [:name, :start_time, :end_time, :terms, :due_date])
      terms = if special_fields[:terms], do: "#{special_fields[:terms]} (#{special_fields[:due_date]})"
      time_range = [special_fields[:start_time], special_fields[:end_time]]
      |>  reject(&is_nil/1) |> map(&sloppy_parse!/1) |> map(&Timex.format!(&1, @time_format)) |> join("–")
      other_fields_selector = (for {_, value} <- other_fields, do: "[contains(normalize-space(.), '#{value}')]") |> join

      class_mappings = %{
        "name" => special_fields[:name],
        "terms" => terms,
        "time-range" => time_range
      }
      selector = [
        "//*[@class='gig']#{other_fields_selector}" |
        for {class_name, text} <- class_mappings, String.length(String.trim text) > 0 do
          "[#{xpath class_name: class_name, text: text}]"
        end
      ] |> join
      expect(session |> has?(Query.xpath selector)).to eq(String.length(negation) == 0)
    end

    {:ok, state}
  end

  @spec atomize_keys(%{optional(String.t) => any}) :: %{optional(atom) => any}
  defp atomize_keys(%{} = map) do
    for {key, value} <- map, into: %{} do
      new_key = key |> to_string |> String.replace(~r{\s}, "_") |> String.to_atom
      {new_key, value}
    end
  end

  @spec gig_attributes(map) :: %{optional(atom) => any}
  defp gig_attributes(%{} = attributes) do
    # TODO: can't we refactor this and maybe remove the time parsing (since timex_ecto does some of it)?
    for {key, value} <- atomize_keys(attributes), into: %{} do
      new_value = cond do
        key == :terms -> with {integer, _} <- Integer.parse(value), do: integer
        key |> to_string |> String.ends_with?("_time") -> sloppy_parse!(value)
        true -> value
      end
      {key, new_value}
    end
  end

  @spec sloppy_parse!(String.t) :: NaiveDateTime.t
  defp sloppy_parse!(time_string) do
    try do
      Timex.parse! time_string, @time_format
    rescue
      Timex.Parse.ParseError -> Timex.parse! time_string, @time_format_fallback
    end
  end

  @spec xpath([class_name: String.t, text: String.t]) :: String.t
  defp xpath(class_name: class_name, text: text) do
    "//*[@class='#{class_name}'][contains(normalize-space(.), '#{text}')]"
  end
end
