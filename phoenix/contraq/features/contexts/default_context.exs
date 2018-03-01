defmodule DefaultContext do
  use WhiteBread.Context

  import_steps_from DefaultContext.UserSteps
  import_steps_from DefaultContext.UserSessionSteps
  import_steps_from DefaultContext.WebSteps

  {:ok, _} = Application.ensure_all_started(:faker)
  Application.put_env(:wallaby, :base_url, ContraqWeb.Endpoint.url)
  {:ok, _} = Application.ensure_all_started(:wallaby)

  feature_starting_state fn ->
    %{}
  end

  scenario_starting_state fn state ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Contraq.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Contraq.Repo, {:shared, self()})
    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Contraq.Repo, self())
    {:ok, session} = Wallaby.start_session #metadata: metadata
    state |> put_in([:session], session)
  end

  scenario_finalize fn _status, _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(Contraq.Repo, [])
  end
end

defmodule DefaultContext.UserSteps do
  use WhiteBread.Context
  alias Contraq.Factory

  given_ "the following user exists:", fn state, {:table_data, [attributes]} ->
    Factory.insert! :user, attributes
    {:ok, state}
  end
end

defmodule DefaultContext.UserSessionSteps do
  use Wallaby.DSL
  use WhiteBread.Context
  import ContraqWeb.Router.Helpers
  alias Contraq.Factory
  alias ContraqWeb.Endpoint

  given_ "I am not logged in", fn %{session: session} = state ->
    session |> visit(session_path Endpoint, :delete)
    {:ok, state}
  end

  given_ ~r/^I am logged in with e-?mail "(?<email>[^"]+)" and password "(?<password>[^"]+)"$/,
  fn %{session: session} = state, attributes ->
    Factory.insert! :user, attributes
    session |> visit(session_path Endpoint, :new) |> login_as(attributes)
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

defmodule DefaultContext.WebSteps do
  use Wallaby.DSL
  use WhiteBread.Context
  import ContraqWeb.Router.Helpers
  alias ContraqWeb.Endpoint

  when_ "I go to the login page", fn %{session: session} = state ->
    session |> visit(session_path Endpoint, :new)
    {:ok, state}
  end
end
