defmodule Paper.Factory do
  use ExMachina.Ecto, repo: Paper.Repo

  # This is a sample factory to make sure our setup is working correctly.

  def user_factory do
    first_name = Faker.Name.first_name()
    last_name = Faker.Name.last_name()

    %Paper.User{
      email: "#{last_name}.#{first_name}@example.com",
      first_name: first_name,
      last_name: last_name
    }
  end
end
