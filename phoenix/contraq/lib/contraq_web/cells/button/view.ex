defmodule ContraqWeb.ButtonCell do
  use ContraqWeb, :cell
  alias ContraqWeb.Endpoint

  defp css_class(%{action: action, model: model}) do
    Enum.join [:button, action, model_name(model)], " "
  end

  defp icon_name(:edit) do
    "pencil"
  end

  defp icon_name(:new) do
    "plus-circle"
  end

  defp link_options(%{action: action, model: model}) do
    apply ContraqWeb.Router.Helpers, :"#{model_name model}_path", [Endpoint, action]
  end

  defp model_name(model) do
    model |> to_string |> Phoenix.Naming.underscore
  end

  defp text(%{action: action, model: model} = assigns) do
    assigns[:text] || Gettext.gettext(ContraqWeb.Gettext, "#{Phoenix.Naming.humanize(action)} #{model_name(model)}")
  end
end
