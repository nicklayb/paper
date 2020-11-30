defmodule Paper.Queries.Query do
  defmacro __using__(_) do
    quote do
      import Ecto.Query
      alias Paper.{Queries.Pagination, Repo}

      def paginate(query, page, per_page) do
        offset = (page - 1 ) * per_page

        query
        |> limit(^per_page)
        |> offset(^offset)
      end

      def fetch(query, %Pagination{per_page: per_page, page: page}) do
        records =
          query
          |> paginate(page, per_page)
          |> Repo.all()

        {records, Repo.aggregate(query, :count)}
      end
    end
  end
end
