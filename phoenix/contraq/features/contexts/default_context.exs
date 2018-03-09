defmodule DefaultContext do
  use WhiteBread.Context

  import_steps_from DebugSteps
  import_steps_from GigSteps
  import_steps_from UserSteps
  import_steps_from UserSessionSteps
  import_steps_from WebSteps

  {:ok, _} = Application.ensure_all_started(:faker)
  Application.put_env(:wallaby, :base_url, ContraqWeb.Endpoint.url)
  {:ok, _} = Application.ensure_all_started(:wallaby)
  {:ok, _} = ESpec.start

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

  scenario_finalize fn _status, %{session: session} ->
    :ok = Wallaby.end_session session
    Ecto.Adapters.SQL.Sandbox.checkin(Contraq.Repo, [])
  end
end
