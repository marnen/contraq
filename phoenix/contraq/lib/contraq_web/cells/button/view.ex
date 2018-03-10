defmodule ContraqWeb.ButtonCell do
  use ContraqWeb, :cell
  alias ContraqWeb.Endpoint

  @icon_names %{
    edit: "pencil",
    new: "plus-circle",
    save: "check-circle"
  }

  defp css_class(%{action: action, model: model}) do
    Enum.join [:button, action, model_underscored(model)], " "
  end

  defp friendly_name(model) do
    String.downcase Phoenix.Naming.humanize model_underscored(model)
  end

  defp icon_name(action) do
    @icon_names[action]
  end

  defp link_options(%{action: action, model: model}) do
    args = if action == :edit, do: [Endpoint, action, model], else: [Endpoint, action]
    apply ContraqWeb.Router.Helpers, :"#{model_underscored model}_path", args
  end

  @spec model_underscored(%Phoenix.HTML.Form{data: struct}) :: String.t
  defp model_underscored(%Phoenix.HTML.Form{data: struct}), do: model_underscored struct

  @spec model_underscored(struct) :: String.t
  defp model_underscored(%{__struct__: module}), do:     Phoenix.Naming.resource_name(module)

  @spec model_underscored(atom | String.t) :: String.t
  defp model_underscored(model) do
    model |> to_string |> Phoenix.Naming.underscore
  end

  defp text(%{action: action, model: model} = assigns) do
    assigns[:text] || Gettext.gettext(ContraqWeb.Gettext, "#{Phoenix.Naming.humanize(action)} #{friendly_name model}")
  end
end
