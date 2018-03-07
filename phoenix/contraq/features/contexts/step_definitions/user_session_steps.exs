defmodule UserSessionSteps do
  use WhiteBread.Context
  use StepHelpers.Web
  alias Contraq.Factory

  given_ "I am not logged in", fn %{session: session} = state ->
    session |> visit(session_path Endpoint, :delete)
    {:ok, state}
  end

  given_ ~r/^I am logged in(?: with e-?mail "(?<email>[^"]+)" and password "(?<password>[^"]+)")?$/,
  fn %{session: session} = state, attributes ->
    cleaned_attributes = attributes |> Enum.reject(fn {_, value} -> value == "" end) |> Enum.into(%{})
    user = Factory.insert! :user, cleaned_attributes
    session |> visit(session_path Endpoint, :new) |> login_as(user)
    {:ok, state}
  end

  when_ ~r/^I log in with e-?mail "(?<email>[^"]+)" and password "(?<password>[^"]+)"$/,
  fn %{session: session} = state, attributes ->
    session |> login_as(attributes)
    {:ok, state}
  end

  when_ "I log out", fn %{session: session} = state ->
    # TODO: we should use method DELETE for this
    session |> visit(session_path Endpoint, :delete)
    {:ok, state}
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

  defp login_as(session, %{email: email, password: password}) do
    session
    |> fill_in(Query.text_field("Email"), with: email)
    |> fill_in(Query.text_field("Password"), with: password)
    |> click(Query.button "Sign In")
  end
end
