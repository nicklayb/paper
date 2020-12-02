defmodule Paper.Queries.Query do
  defmacro __using__(_) do
    quote do
      import Ecto.Query
      alias Paper.{Queries.QueryParameters, Repo}

      def paginate(query, %QueryParameters{page: page, per_page: per_page}) do
        offset = (page - 1 ) * per_page

        query
        |> limit(^per_page)
        |> offset(^offset)
      end

      def sort(query, %QueryParameters{sort_by: nil, sort_order: sort_order}), do: query
      def sort(query, %QueryParameters{sort_by: sort_by, sort_order: sort_order}) do
        query
        |> order_by([q], {^sort_order, ^sort_by})
      end

      def fetch(query, %QueryParameters{} = query_parameters) do
        records =
          query
          |> paginate(query_parameters)
          |> sort(query_parameters)
          |> Repo.all()

        {records, Repo.aggregate(query, :count)}
      end
    end
  end
end
