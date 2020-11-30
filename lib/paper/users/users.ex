defmodule Paper.Users do
  use Paper, :context
  alias Paper.{Repo, User}

  @spec create(map() | Ueberauth.t()) :: {:ok, %User{}}
  def create(%Ueberauth.Auth.Info{email: email, first_name: first_name, last_name: last_name}) do
    create(%{email: email, first_name: first_name, last_name: last_name})
  end

  def create(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update(%User{}, map()) :: {:ok, %User{}}
  def update(%User{} = user, attrs \\ %{}) do
    user
    |> User.changeset(attrs)
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

  @spec list :: [%User{}]
  def list, do: Repo.all(User)

  @spec get_or_register(Ueberauth.Auth.t()) :: {:ok, %User{}} | {:error, Ecto.Changeset.t()}
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

  @spec change(%User{}, map()) :: Ecto.Changeset.t()
  def change(user \\ %User{}, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
