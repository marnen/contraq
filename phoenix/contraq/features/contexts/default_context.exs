defmodule DefaultContext do
  use WhiteBread.Context

  feature_starting_state fn ->
    System.put_env "QT_QPA_PLATFORM", "offscreen" # see https://github.com/ariya/phantomjs/issues/14376
    {:ok, _} = Application.ensure_all_started(:wallaby)
    %{}
  end

  scenario_starting_state fn state ->
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Contraq.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Contraq.Repo, {:shared, self()})
    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Contraq.Repo, self())
    {:ok, session} = Wallaby.start_session metadata: metadata
    state |> put_in([:session], session)
  end

  scenario_finalize fn _state ->
    Ecto.Adapters.SQL.Sandbox.checkin(Contraq.Repo, [])
  end

  end
end
