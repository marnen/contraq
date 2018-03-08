defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias Contraq.Repo
    end
  end

  def controller do
    quote do
      alias Contraq
      import ContraqWeb.Router.Helpers

      @endpoint ContraqWeb.Endpoint
    end
  end

  def view do
    quote do
      import ContraqWeb.Router.Helpers
    end
  end

  def channel do
    quote do
      alias Contraq.Repo

      @endpoint ContraqWeb.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
