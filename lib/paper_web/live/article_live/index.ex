defmodule PaperWeb.ArticleLive.Index do
  use PaperWeb, :live_view
  use PaperWeb.TableView
  alias Paper.{Article, Articles, Queries.ArticleQuery}
  alias PaperWeb.TableView
  alias PaperWeb.LiveComponent.Modal

  def mount(_params, session, socket) do
    {:ok, current_user} = PaperWeb.Live.AuthHelper.load_user(session)

    socket = assign(socket,
      changeset: Articles.new(),
      patch_route_mfa: {Routes, :article_index_path, [:index]},
      current_user_id: current_user.id
    )

    {:ok, socket, temporary_assigns: [records: []]}
  end

  def handle_params(params, _url, socket) do
    socket = socket
    |> assign(query_parameters: query_parameters(params))
    |> apply_action(socket.assigns.live_action, params)

    send(self(), :update)
    {:noreply, socket}
  end

  def apply_action(socket, :index, _params), do: assign(socket, show_modal: false)
  def apply_action(socket, :new, _params), do: assign(socket, show_modal: true)
  def apply_action(socket, _live_action, _params) do
    push_patch(socket, to: Routes.article_index_path(socket, :index), replace: true)
  end

  def get_records(socket) do
    Article
    |> ArticleQuery.preload()
    |> ArticleQuery.fetch(socket.assigns.query_parameters)
  end

  table_event_handlers()

  def get_title(article) do
    Enum.at(article.article_contents, 0).title
  end

  def handle_event("create_article", %{"article" => params}, socket) do
    params = Map.put(params, "author_id", socket.assigns.current_user_id)

    case Articles.create(params) do
      {:ok, article} ->
        socket = redirect(socket, to: Routes.article_edit_path(socket, :edit, article.id))
        {:noreply, socket}
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end
end
