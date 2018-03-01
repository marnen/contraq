defmodule WebSteps do
  use WhiteBread.Context
  use StepHelpers.Web

  when_ "I go to the login page", fn %{session: session} = state ->
    session |> visit(session_path Endpoint, :new)
    {:ok, state}
  end
end
