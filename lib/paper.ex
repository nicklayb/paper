defmodule Paper do
  @moduledoc """
  Paper keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def context do
    quote do
      use Paper.Context
    end
  end

  def schema do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end

  def query do
    quote do
      use Paper.Query
      import Ecto.Query
    end
  end

  @doc """
  When used, dispatch to the appropriate context/schema/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
