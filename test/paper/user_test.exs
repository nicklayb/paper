defmodule Paper.UsersTest do
  use Paper.DataCase, async: true

  alias Paper.Factory

  alias Paper.Users

  test "create/1 should create a user and return it" do
    user_factory = Factory.user_factory
    {:ok, user} = Users.create(user_factory)

    assert user.email == user_factory.email
    assert user.first_name == user_factory.first_name
    assert user.last_name == user_factory.last_name
  end

  test "get/1 should return the right user" do
    {:ok, user} = Users.create(Factory.user_factory)
    {:ok, user_from_db}  = Users.get(user.id)

    assert user_from_db.email == user.email
  end

  test "get_by_email/1 should return the right user" do
    {:ok, user} = Users.create(Factory.user_factory)
    {:ok, user_from_db}  = Users.get_by_email(user.email)

    assert user_from_db.email == user.email
  end

  test "update/1 should update a user and return it" do
    {:ok, created_user} = Users.create(Factory.user_factory)
    {:ok, updated_user} = Users.update(created_user, %{email: "john@doe.com"})

    assert created_user.email != updated_user.email
  end
end
