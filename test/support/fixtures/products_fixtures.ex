defmodule Inventory.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Inventory.Products` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        quantity: 42,
        unit_price: 120.5
      })
      |> Inventory.Products.create_item()

    item
  end
end
