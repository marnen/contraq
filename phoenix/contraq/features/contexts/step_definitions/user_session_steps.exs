defmodule UserSessionSteps do
  use WhiteBread.Context
  use StepHelpers.Web
  alias Contraq.Factory
  import Contraq.Coherence.Schemas, only: [get_user_by_email: 1]
  import Map, only: [merge: 2]

  given_ "I am not logged in", fn %{session: session} = state ->
    new_session = session |> visit(session_path Endpoint, :delete)
    {:ok, put_in(state[:session], new_session)}
  end

  given_ ~r/^I am logged in(?: with e-?mail "(?<email>[^"]+)" and password "(?<password>[^"]+)")?$/,
  fn %{session: session} = state, %{email: email} = raw_attributes ->
    cleaned_attributes = raw_attributes |> Enum.reject(fn {_, value} -> value == "" end) |> Enum.into(%{})
    user_attributes = Map.from_struct(Factory.build :user, cleaned_attributes) # TODO: let's make an attributes method
    user = get_user_by_email(email) || Factory.insert! :user, user_attributes
    new_session = session |> visit(session_path Endpoint, :new) |> login_as(user_attributes)
    {:ok, merge(state, %{current_user: user, session: new_session})}
  end

  when_ ~r/^I log in with e-?mail "(?<email>[^"]+)" and password "(?<password>[^"]+)"$/,
  fn %{session: session} = state, %{email: email} = attributes ->
    new_session = session |> login_as(attributes)
    {:ok, merge(state, %{current_user: get_user_by_email(email), session: new_session})}
  end

  when_ "I log out", fn %{session: session} = state ->
    # TODO: we should use method DELETE for this
    session |> visit(session_path Endpoint, :delete)
    {:ok, Map.delete(state, [:current_user])}
  end

  then_ ~r/^I should be logged in as "(?<email>[^"]+)"$/,
  fn %{session: session} = state, %{email: email} ->
    assert session |> has_text?("Logged in as #{email}")
    {:ok, state}
  end

  then_ "I should not be logged in", fn %{session: session} = state ->
    refute session |> has_text?("Logged in as")
    {:ok, state}
  end

  @spec login_as(Browser.t, %{email: String.t, password: String.t}) :: Browser.t
  defp login_as(session, %{email: email, password: password}) do
    session
    |> fill_in(Query.text_field("Email"), with: email)
    |> fill_in(Query.text_field("Password"), with: password)
    |> click(Query.button "Sign In")
  end
end
