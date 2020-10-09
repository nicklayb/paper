defmodule Paper.Users do
  @moduledoc """
  This is the context for the users.
  """
  use Paper.Context
  alias Paper.{Repo, User}

  @spec create(map()) :: {:ok, %User{}}
  def create(%{email: email, first_name: first_name, last_name: last_name}) do
    %User{}
    |> User.changeset(%{email: email, first_name: first_name, last_name: last_name})
    |> Repo.insert()
  end

  @spec update(%User{}, map()) :: {:ok, %User{}}
  def update(%User{} = user, params \\ %{}) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  @spec get(integer()) :: {:ok, %User{}}
  def get(id) do
    User
    |> Repo.get(id)
    |> safe_get()
  end

  @spec get_by_email(binary()) :: {:ok, %User{}}
  def get_by_email(email) do
    User
    |> Repo.get_by(email: email)
    |> safe_get()
  end
end
