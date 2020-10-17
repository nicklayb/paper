defmodule PaperWeb.Table.PaginationComponent do
  use PaperWeb, :live_component

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    route = route_path(socket, [
      page: socket.assigns.pagination.page,
      per_page: String.to_integer(per_page)
    ])

    socket = push_patch(socket, to: route)
    {:noreply, socket}
  end

  def route_path(socket, path_params) do
    {module, func, params} = socket.assigns.pagination.route
    params = ([socket | params] ++ [path_params])
    apply(module, func, params)
  end

  def per_page_options do
    [15, 50, 100]
  end
end
