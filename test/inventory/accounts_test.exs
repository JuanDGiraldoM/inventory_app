defmodule Inventory.AccountsTest do
  use Inventory.DataCase

  alias Inventory.Accounts

  describe "users" do
    alias Inventory.Accounts.User

    import Inventory.AccountsFixtures

    @invalid_attrs %{age: nil, balance: nil, lastname: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{age: 42, balance: 120.5, lastname: "some lastname", name: "some name"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.age == 42
      assert user.balance == 120.5
      assert user.lastname == "some lastname"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        age: 43,
        balance: 456.7,
        lastname: "some updated lastname",
        name: "some updated name"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.age == 43
      assert user.balance == 456.7
      assert user.lastname == "some updated lastname"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
