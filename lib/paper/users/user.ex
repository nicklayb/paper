defmodule Paper.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)

    timestamps()
  end

  @required ~w(email)a
  @optional ~w(first_name last_name)a
  def changeset(user, params) do
    user
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
    |> unique_constraint(:email)
  end

  def full_name(user), do: "#{user.first_name} #{user.last_name}"
end
