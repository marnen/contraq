defmodule Contraq.Naming do
  @spec dasherize(String.t) :: String.t
  def dasherize(string), do: String.replace string, "_", "-"
end
