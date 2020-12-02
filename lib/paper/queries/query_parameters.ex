defmodule Paper.Queries.QueryParameters do
  alias __MODULE__
  require Integer

  defstruct page: 0,
            per_page: 10,
            total_pages: 0,
            sort_by: nil,
            sort_order: :asc

  def init() do
    %QueryParameters{}
  end
end
