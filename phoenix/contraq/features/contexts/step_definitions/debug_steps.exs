defmodule DebugSteps do
  use WhiteBread.Context

  then_ "show me the page source", fn state ->
    IO.puts Wallaby.Browser.page_source state[:session]
    {:ok, state}
  end
end
