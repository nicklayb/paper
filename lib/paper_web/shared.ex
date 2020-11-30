defmodule PaperWeb.Shared do
  def shared(template, assigns) do
    PaperWeb.SharedView.render(template, assigns)
  end

  def shared(template, assigns, do: block) do
    PaperWeb.SharedView.render(template, Keyword.merge(assigns, [do: block]))
  end
end
