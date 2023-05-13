defmodule Inventory.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Inventory.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        balance: 120.5,
        lastname: "some lastname",
        name: "some name"
      })
      |> Inventory.Accounts.create_user()

    user
  end
end
