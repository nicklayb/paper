defmodule UserSeed do
  alias Paper.{Repo, Users}

  def seed() do
    Enum.map(users(), fn params ->
      {:ok, user} = seed_user(params)
    end)

    Enum.map(1..200, fn n ->
      {:ok, user} = seed_user(%{
        first_name: "John",
        last_name: "Doe - #{n}",
        email: "john#{n}@doe.com"
      })
    end)
  end

  def seed_user(params) do
    Users.create(params)
  end

  defp users() do
    [
      %{
        first_name: "Richard",
        last_name: "Hendricks",
        email: "richard@piedpiper.com"
      },
      %{
        first_name: "Dinesh",
        last_name: "Chugtai",
        email: "dinesh@piedpiper.com"
      },
      %{
        first_name: "Bertram",
        last_name: "Gilfoyle",
        email: "gilfoyle@piedpiper.com"
      },
      %{
        first_name: "Jared",
        last_name: "Dunn",
        email: "jared@piedpiper.com"
      },
    ]
  end
end
