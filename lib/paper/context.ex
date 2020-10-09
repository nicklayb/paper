defmodule Paper.Context do
  @doc """
  Wraps the value in a :ok/:error tuple

  If the value is `nil`, it'll return `{:error, :not_found}`, otherwise it'll return `{:ok, value}`
  """
  def safe_get(nil), do: {:error, :not_found}
  def safe_get(value), do: {:ok, value}

  defmacro __using__(_) do
    quote do
      import Paper.Context
    end
  end
end
