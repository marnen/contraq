defmodule UserSteps do
  use WhiteBread.Context
  alias Contraq.Factory

  given_ ~r/^the following users? exists?:$/, fn state, %{table_data: table_data} ->
    for attributes <- table_data, do: Factory.insert! :user, attributes
    {:ok, state}
  end
end
