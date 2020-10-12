defmodule Paper.UsersTest do
  use Paper.DataCase, async: true

  import Paper.Factory

  alias Paper.Users

  describe "users" do
    test "create/1 should create a user and return it" do
      params = params_for(:user)
      assert {:ok, user} = Users.create(params)
      assert user.email == params.email
    end

    test "create/1 should not create a user" do
      params = params_for(:user, %{email: nil})
      assert {:error, _error_changeset} = Users.create(params)
    end

    test "update/1 should update a user and return it" do
      user = insert(:user)
      assert {:ok, updated_user} = Users.update(user, params_for(:user, %{email: "rich@piedpiper.com"}))
      assert user.email != updated_user.email
    end

    test "delete/1 should delete a user" do
      user = insert(:user)
      assert {:ok, deleted_user} = Users.delete(user)
      refute Users.get(user.id)
    end

    test "get/1 should return the right user" do
      user = insert(:user)
      user_from_db  = Users.get(user.id)

      assert user_from_db.email == user.email
    end

    test "get_by_email/1 should return the right user" do
      user = insert(:user)
      user_from_db  = Users.get_by_email(user.email)

      assert user_from_db.email == user.email
    end
  end

end
