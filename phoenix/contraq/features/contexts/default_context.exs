defmodule DefaultContext do
  use WhiteBread.Context

  feature_starting_state fn ->
    {:ok, _} = Application.ensure_all_started(:wallaby)
  end
end
