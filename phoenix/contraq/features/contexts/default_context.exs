defmodule DefaultContext do
  use WhiteBread.Context

  feature_starting_state fn ->
    System.put_env "QT_QPA_PLATFORM", "offscreen" # see https://github.com/ariya/phantomjs/issues/14376
    {:ok, _} = Application.ensure_all_started(:wallaby)
  end
end
