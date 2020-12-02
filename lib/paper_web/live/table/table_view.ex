defmodule PaperWeb.TableView do
  use PaperWeb, :view
  use Phoenix.View, root: "lib/paper_web", path: "live/table", namespace: PaperWeb

  defmacro table_event_handlers() do
    quote do
      def handle_event("sort", %{"by" => sort_key}, socket) do
        send(self(), {:sort, sort_key})
        {:noreply, socket}
      end

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

  def pagination_range(%{total_pages: total_pages} = query_parameters) when total_pages > 0, do: evaluate_pagination_range(query_parameters)
  def pagination_range(_query_parameters), do: []

  @number_of_pages_showned 5
  def evaluate_pagination_range(%{total_pages: total_pages, page: page} = query_parameters) do
    cond do
      total_pages <= @number_of_pages_showned ->
        1..total_pages
      not prev?(query_parameters) || page < @number_of_pages_showned / 2 ->
        Enum.take_while(1..total_pages, &(&1 <= @number_of_pages_showned))
      not next?(query_parameters) || page > total_pages - (@number_of_pages_showned / 2) ->
        (total_pages - (@number_of_pages_showned - 1))..total_pages
      true ->
        (page - 2)..(page + 2)
    end
  end

  def last_page(query_parameters), do: query_parameters.total_pages
  def prev?(query_parameters), do: query_parameters.page > 1
  def next?(query_parameters), do: query_parameters.page < query_parameters.total_pages


  def per_page_options, do: [10, 25, 50]

  defmacro __using__(_) do
    quote do
      import PaperWeb.TableView
      alias Paper.Queries.QueryParameters

      table_event_handlers()

      def get_records(_), do: []

      def route_path(%{assigns: %{patch_route_mfa: {module, func, args}}} = socket, path_params) do
        args = ([socket | args] ++ [path_params])
        apply(module, func, args)
      end

      def query_parameters(params) do
        %QueryParameters{
          page: String.to_integer(params["page"] || "1"),
          per_page: String.to_integer(params["per_page"] || "10"),
          sort_by: String.to_existing_atom(params["sort_by"]) || nil,
          sort_order: String.to_existing_atom(params["sort_order"]) || :asc,
        }
      end

      def update_pagination(query_parameters, total_records) do
        query_parameters = Map.put(query_parameters, :total_pages, ceil(total_records / query_parameters.per_page))
        Map.update(query_parameters, :page, 1, &(if &1> query_parameters.total_pages, do: query_parameters.total_pages, else: &1))
      end

      def handle_info(:update, %{assigns: %{query_parameters: query_parameters}} = socket) do
        {records, total_records} = get_records(socket)

        query_parameters = query_parameters
        |> update_pagination(total_records)

        socket = assign(socket, records: records, query_parameters: query_parameters)

        {:noreply, socket}
      end

      def handle_info({:sort, sort_key}, %{assigns: %{query_parameters: %{sort_order: :asc} = query_parameters}} = socket) do
        route = route_path(socket, sort_by: sort_key, sort_order: :desc)
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      def handle_info({:sort, sort_key}, %{assigns: %{query_parameters: %{sort_order: :desc} = query_parameters}} = socket) do
        route = route_path(socket, sort_by: sort_key, sort_order: :asc)
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      def handle_info(:next, socket) do
        query_parameters = socket.assigns.query_parameters
        route = route_path(socket, page: query_parameters.page + 1, per_page: query_parameters.per_page)
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      def handle_info(:prev, socket) do
        query_parameters = socket.assigns.query_parameters

        if query_parameters.page <= 1 do
          {:noreply, socket}
        else
          route = route_path(socket, page: query_parameters.page - 1, per_page: query_parameters.per_page)
          socket = push_patch(socket, to: route)

          {:noreply, socket}
        end
      end

      def handle_info({:set_page, page}, socket) do
        query_parameters = socket.assigns.query_parameters
        route = route_path(socket, page: String.to_integer(page), per_page: query_parameters.per_page)
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      def handle_info({:select_per_page, per_page}, socket) do
        route = route_path(socket, page: socket.assigns.query_parameters.page, per_page: String.to_integer(per_page))
        socket = push_patch(socket, to: route)

        {:noreply, socket}
      end

      # defp sort_order_icon(column, %{sort_by: sort_by, sort_order: :asc}) when column == sort_by, do: "▲"
      # defp sort_order_icon(column, %{sort_by: sort_by, sort_order: :asc}) when column == sort_by, do: "▼"
      # defp sort_order_icon(_, _, _), do: ""

      defoverridable get_records: 1
    end
  end
end
