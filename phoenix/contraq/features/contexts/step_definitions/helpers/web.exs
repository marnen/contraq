defmodule StepHelpers.Web do
  defmacro __using__(_opts) do
    quote do
      use Wallaby.DSL
      import ContraqWeb.Router.Helpers
      alias ContraqWeb.Endpoint
    end
  end
end
