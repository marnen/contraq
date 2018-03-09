defmodule WebSteps do
  use WhiteBread.Context
  use StepHelpers.Web

  given_ ~r/^I am on (?<page_name>.+)$/, fn %{session: session} = state, %{page_name: page_name} ->
    new_session = session |> visit(path_to page_name)
    {:ok, put_in(state[:session], new_session)}
  end

  when_ ~r/^I click "(?<text>[^"]+)"$/,
  fn %{session: session} = state, %{text: text} ->
    new_session = session |> click_link_or_button(text)
    {:ok, put_in(state[:session], new_session)}
  end

  when_ "I fill in the following:", fn  %{session: session} = state, {:table_data, table_data} ->
    new_session = Enum.reduce table_data, session, fn %{field: field, value: value}, session ->
      session |> fill_in(Query.text_field(field), with: value)
    end
    {:ok, put_in(state[:session], new_session)}
  end

  when_ ~r/^I go to (?<page_name>.+)$/, fn %{session: session} = state, %{page_name: page_name} ->
    new_session = session |> visit(path_to page_name)
    {:ok, state |> put_in([:session], new_session)}
  end

  then_ ~r/^I should be on (?<page_name>.+)$/, fn %{session: session} = state, %{page_name: page_name} ->
    assert current_path(session) == path_to(page_name)
    {:ok, state}
  end

  then_ ~r/^I should (?<negation>not )?see "(?<text>[^"]+)"$/, fn %{session: session} = state, %{negation: negation, text: text} ->
    assert (session |> has_text?(text)) == (String.length(negation) == 0)
    {:ok, state}
  end

  defp click_link_or_button(session, text) do
    try do
      session |> click(Query.link text)
    rescue
      Wallaby.QueryError -> session |> click(Query.button text)
    end
  end

  defp path_to(page_name) do
    case page_name do
      "the gigs page" -> gig_path(Endpoint, :index)
      "the login page" -> session_path(Endpoint, :new)
      "the new gig page" -> gig_path(Endpoint, :new)
      _ -> raise ArgumentError, message: "No mapping defined for page '#{page_name}'. Please add a mapping in #{__ENV__.file}."
    end
  end
end
