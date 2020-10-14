defmodule PaperWeb.Components do
  def component(template, assigns) do
    PaperWeb.Components.View.render(template, assigns)
  end

  def component(template, assigns, do: block) do
    PaperWeb.Components.View.render(template, Keyword.merge(assigns, [do: block]))
  end
end
