defmodule WebSteps do
  use WhiteBread.Context, test_library: :espec
  use StepHelpers.Web

  given_ ~r/^I am on (?<page_name>.+)$/, fn %{session: session} = state, %{page_name: page_name} ->
    new_session = session |> visit(path_to page_name, state)
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
    new_session = session |> visit(path_to page_name, state)
    {:ok, state |> put_in([:session], new_session)}
  end

  then_ ~r/^I should not be able to get to (?<page_name>.+)$/,
  fn %{session: session} = state, %{page_name: page_name} ->
    path = path_to page_name, state
    session |> visit(path)
    expect(current_path session).not_to eq path
    {:ok, state}
  end

  then_ ~r/^I should (?<negation>not )?be on (?<page_name>.+)$/, fn %{session: session} = state, %{negation: negation, page_name: page_name} ->
    expect(current_path(session) == path_to(page_name, state)).to eq(String.length(negation) == 0)
    {:ok, state}
  end

  then_ ~r/^I should (?<negation>not )?see "(?<text>[^"]+)"$/, fn %{session: session} = state, %{negation: negation, text: text} ->
    expect(session |> has_text?(text)).to eq(String.length(negation) == 0)
    {:ok, state}
  end

  defp click_link_or_button(session, text) do
    try do
      session |> click(Query.link text)
    rescue
      Wallaby.QueryError -> session |> click(Query.button text)
    end
  end

  @spec path_to(String.t, map) :: String.t
  defp path_to(page_name, state \\ %{}) do
    alias Contraq.Gigs.Gig
    alias Contraq.Repo
    cond do
      page_name == "the edit page for the gig" -> gig_path(Endpoint, :edit, state[:gig])
      captures = Regex.named_captures ~r/^the gig page for "(?<name>.+)"$/, page_name ->
        with gig <- Repo.get_by!(Gig, name: captures["name"]) do
          gig_path(Endpoint, :show, gig)
        end
      page_name == "the gigs page" -> gig_path(Endpoint, :index)
      page_name == "the gig's page" -> gig_path(Endpoint, :show, state[:gig])
      page_name == "the login page" -> session_path(Endpoint, :new)
      page_name == "the new gig page" -> gig_path(Endpoint, :new)
      true -> raise ArgumentError, message: ~s(No mapping defined for page "#{page_name}". Please add a mapping in #{__ENV__.file}.)
    end
  end
end
