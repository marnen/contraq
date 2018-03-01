defmodule UserSteps do
  use WhiteBread.Context
  alias Contraq.Factory

  given_ "the following user exists:", fn state, {:table_data, [attributes]} ->
    Factory.insert! :user, attributes
    {:ok, state}
  end
end
