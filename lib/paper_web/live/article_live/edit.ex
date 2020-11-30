defmodule PaperWeb.ArticleLive.Edit do
  use PaperWeb, :live_view
  alias Ecto.Changeset
  alias Paper.{Article, Articles, ArticleContent}

  def mount(%{"id" => id}, session, socket) do
    article = Articles.get(id) |> Articles.preload()
    changeset = Articles.change(article)
    default_locale(changeset)

    socket =
      assign(socket, article: article, changeset: changeset, locale: default_locale(changeset))

    {:ok, socket}
  end

  def default_locale(changeset) do
    changeset
    |> Changeset.get_field(:article_contents)
    |> Enum.at(0)
    |> Map.get(:locale)
  end

  def locale(form), do: form.data.locale

  def locale_selector(locale) do
    ~E"""
      <div class="field">
        <label class="label">Locale</label>
        <div class="select">
          <select name="locale">
            <%= Enum.map(["en", "fr"], &(content_tag(:option, &1, value: &1, selected: locale == &1))) %>
          </select>
        </div>
      </div>
    """
  end

  def handle_event("locale-change", %{"locale" => locale}, %{assigns: %{article: article}} = socket) do
    mapped_ac = Enum.map(article.article_contents, &(%{id: &1.id}))
    article_content_params =
      case Enum.find(article.article_contents, &(&1.locale == locale)) do
        nil -> mapped_ac ++ [%{locale: locale}]
        _ -> mapped_ac
      end

    changeset = Articles.change(article, %{article_contents: article_content_params})
    socket = assign(socket, locale: locale, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("article_change", %{"article" => article_params}, %{assigns: %{changeset: changeset, article: article, locale: locale}} = socket) do
    {:ok, article} = Articles.update(article, article_params)
    socket = assign(socket, article: article, changeset: Articles.change(article))
    {:noreply, socket}
  end
end
