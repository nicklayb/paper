defmodule PaperWeb.Components do
  def component(template, assigns) do
    PaperWeb.ComponentView.render(template, assigns)
  end

  def component(template, assigns, do: block) do
    PaperWeb.ComponentView.render(template, Keyword.merge(assigns, [do: block]))
  end
end
