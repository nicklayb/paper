defmodule Paper.Queries.Pagination do
  alias __MODULE__
  require Integer

  defstruct page: 0,
            per_page: 10,
            total_pages: 0

  def init() do
    %Pagination{}
  end
end
