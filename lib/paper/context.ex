defmodule Paper.Context do

  defmacro __using__(_) do
    quote do
      import Paper.Context
      import Ecto.Query
    end
  end
end
