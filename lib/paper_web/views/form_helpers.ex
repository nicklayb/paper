defmodule PaperWeb.FormHelpers do
  use Phoenix.HTML

  def input_field(form, field, options \\ []) do
    type = options[:type] || Phoenix.HTML.Form.input_type(form, field)
    content_tag :div, class: "field" do
      label = label(form, field, humanize(field), class: "label")
      input = input(type, form, field)
      error = PaperWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  defp state_class(form, field) do
    cond do
      !form.source.action -> ""
      form.errors[field] -> "is-danger "
      true -> ""
    end
  end

  def select_field(form, field, select_options, options \\ []) do
    content_tag :div, class: "field" do
      [
        label(form, field, humanize(field), class: "label"),
        content_tag :div, class: "select" do
          Phoenix.HTML.Form.select(form, field, select_options, options)
        end
      ]
    end
  end

  defp input(:text_input, form, field) do
    class = state_class(form, field) <> "input"
    apply(Phoenix.HTML.Form, :text_input, [form, field, [class: class]])
  end

  defp input(:textarea, form, field) do
    class = state_class(form, field) <> "textarea"
    apply(Phoenix.HTML.Form, :textarea, [form, field, [class: class]])
  end

  defp input(type, form, field, input_options) do
    apply(Phoenix.HTML.Form, type, [form, field, input_options])
  end
end
