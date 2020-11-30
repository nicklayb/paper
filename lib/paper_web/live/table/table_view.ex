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

  def pagination_range(%{total_pages: total_pages} = pagination) when total_pages > 0, do: evaluate_pagination_range(pagination)
  def pagination_range(_pagination), do: []

  @number_of_pages_showned 5
  def evaluate_pagination_range(%{total_pages: total_pages, page: page} = pagination) do
    cond do
      total_pages <= @number_of_pages_showned ->
        1..total_pages
      not prev?(pagination) || page < @number_of_pages_showned / 2 ->
        Enum.take_while(1..total_pages, &(&1 <= @number_of_pages_showned))
      not next?(pagination) || page > total_pages - (@number_of_pages_showned / 2) ->
        (total_pages - (@number_of_pages_showned - 1))..total_pages
      true ->
        (page - 2)..(page + 2)
    end
  end

  def last_page(pagination), do: pagination.total_pages
  def prev?(pagination), do: pagination.page > 1
  def next?(pagination), do: pagination.page < pagination.total_pages


  def per_page_options, do: [10, 25, 50]

  defmacro __using__(_) do
    quote do
      import PaperWeb.TableView
      alias Paper.Queries.Pagination

      def get_records(_), do: []

      def route_path(socket, path_params) do
        {module, func, params} = socket.assigns.patch_route
        params = ([socket | params] ++ [path_params])
        apply(module, func, params)
      end

      def pagination_params(params) do
        %Pagination{
          page: String.to_integer(params["page"] || "1"),
          per_page: String.to_integer(params["per_page"] || "10")
        }
      end

      def update_pagination(pagination, total_records) do
        pagination = Map.put(pagination, :total_pages, ceil(total_records / pagination.per_page))
        pagination = Map.update(pagination, :page, 1, &(if &1> pagination.total_pages, do: pagination.total_pages, else: &1))
      end

      def handle_info(:update, socket) do
        {records, total_records} = get_records(socket)
        socket = assign(
          socket,
          records: records,
          pagination: update_pagination(socket.assigns.pagination, total_records)
        )

        {:noreply, socket}
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
