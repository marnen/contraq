defmodule WebSteps do
  use Wallaby.DSL
  use WhiteBread.Context
  import ContraqWeb.Router.Helpers
  alias ContraqWeb.Endpoint

  when_ "I go to the login page", fn %{session: session} = state ->
    session |> visit(session_path Endpoint, :new)
    {:ok, state}
  end
end
