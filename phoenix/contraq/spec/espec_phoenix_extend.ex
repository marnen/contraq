defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias Contraq.Repo
    end
  end

  def controller do
    quote do
      alias Contraq
      import Contraq.Router.Helpers

      @endpoint Contraq.Endpoint
    end
  end

  def view do
    quote do
      import Contraq.Router.Helpers
    end
  end

  def channel do
    quote do
      alias Contraq.Repo

      @endpoint Contraq.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
