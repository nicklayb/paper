defmodule PaperWeb.UserLive.Index do
  use PaperWeb, :live_view
  use PaperWeb.TableView
  alias Paper.{User, Queries.UserQuery}
  alias PaperWeb.TableView

  def mount(_params, _session, socket) do
    socket = assign(socket, patch_route: {Routes, :user_index_path, [:index]})
    {:ok, socket, temporary_assigns: [records: []]}
  end

  def handle_params(params, _url, socket) do
    socket = assign(socket, pagination: pagination_params(params))

    send(self(), :update)
    {:noreply, socket}
  end

  def get_records(socket) do
    User
    |> UserQuery.fetch(socket.assigns.pagination)
  end

  table_event_handlers()

  def full_name(user), do: User.full_name(user)
end
