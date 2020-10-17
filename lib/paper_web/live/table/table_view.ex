defmodule PaperWeb.TableView do
  use PaperWeb, :view
  use Phoenix.View, root: "lib/paper_web", path: "live/table", namespace: PaperWeb

  defmacro table_event_handlers() do
    quote do
      def handle_event("prev", _, socket) do
        send(self(), :prev)
        {:noreply, socket}
      end

      def handle_event("next", _, socket) do
        send(self(), :next)
        {:noreply, socket}
      end

      def handle_event("set-page", %{"page" => page}, socket) when is_binary(page) do
        send(self(), {:set_page, page})
        {:noreply, socket}
      end

      def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
        send(self(), {:select_per_page, per_page})
        {:noreply, socket}
      end
    end
  end

  def pagination_range(pagination), do: (pagination.page - 2)..(pagination.page + 2)
  def per_page_options, do: [10, 25, 50]

  defmacro __using__(_) do
    quote do
      import PaperWeb.TableView

      def get_records(_), do: []

      def route_path(socket, path_params) do
        {module, func, params} = socket.assigns.patch_route
        params = ([socket | params] ++ [path_params])
        apply(module, func, params)
      end

      def pagination_params(params) do
        page = String.to_integer(params["page"] || "1")
        per_page = String.to_integer(params["per_page"] || "10")
        %{page: page, per_page: per_page}
      end

      def handle_info(:update, socket) do
        records = get_records(socket)
        {:noreply, assign(socket, records: records)}
      end

      def handle_info(:next, socket) do
        pagination = socket.assigns.pagination
        route = route_path(socket, page: pagination.page + 1, per_page: pagination.per_page)
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      def handle_info(:prev, socket) do
        pagination = socket.assigns.pagination

        if pagination.page <= 1 do
          {:noreply, socket}
        else
          route = route_path(socket, page: pagination.page - 1, per_page: pagination.per_page)
          socket = push_patch(socket, to: route)
          {:noreply, socket}
        end
      end

      def handle_info({:set_page, page}, socket) do
        pagination = socket.assigns.pagination
        route = route_path(socket, page: String.to_integer(page), per_page: pagination.per_page)
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      def handle_info({:select_per_page, per_page}, socket) do
        route = route_path(socket, page: socket.assigns.pagination.page, per_page: String.to_integer(per_page))
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      defoverridable get_records: 1
    end
  end
end
