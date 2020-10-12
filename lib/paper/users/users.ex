defmodule Paper.Users do
  use Paper.Context
  alias Paper.Repo
  alias Paper.User

  def create(%Ueberauth.Auth.Info{email: email, first_name: first_name, last_name: last_name}) do
    create(%{email: email, first_name: first_name, last_name: last_name})
  end

  @spec create(map()) :: {:ok, %User{}}
  def create(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  @spec update(%User{}, map()) :: {:ok, %User{}}
  def update(%User{} = user, params \\ %{}) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  @spec delete(%User{}) :: {:ok, %User{}}
  def delete(user) do
    Repo.delete(user)
  end

  @spec get(integer()) :: %User{} | nil
  def get(id) do
    User
    |> Repo.get(id)
  end

  @spec get_by_email(binary()) :: %User{} | nil
  def get_by_email(email) do
    User
    |> Repo.get_by(email: email)
  end

  @spec get_or_register(%Ueberauth.Auth{}) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def get_or_register(%Ueberauth.Auth{info: %{email: email} = info }) do
    case get_by_email(email) do
      %User{} = user -> sync(user, info)
      nil -> create(info)
    end
  end

  def sync(%User{} = user, %Ueberauth.Auth.Info{email: email, first_name: first_name, last_name: last_name}) do
    user
    |> User.changeset(%{email: email, first_name: first_name, last_name: last_name})
    |> Repo.update
  end

  @spec change(%User{}) :: %Ecto.Changeset{}
  def change(user \\ %User{}) do
    User.changeset(user, %{})
  end
end
