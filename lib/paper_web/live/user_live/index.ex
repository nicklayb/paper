defmodule PaperWeb.UserLive.Index do
  use PaperWeb, :live_view
  use PaperWeb.TableView
  alias Paper.{User, Queries.UserQuery}
  alias PaperWeb.TableView

  def mount(_params, _session, socket) do
    socket = assign(socket, patch_route_mfa: {Routes, :user_index_path, [:index]})
    {:ok, socket, temporary_assigns: [records: []]}
  end

  def handle_params(params, _url, socket) do
    socket = assign(socket, query_parameters: query_parameters(params))

    send(self(), :update)
    {:noreply, socket}
  end

  def get_records(%{assigns: %{query_parameters: query_parameters}}) do
    User
    |> UserQuery.fetch(query_parameters)
  end
end
