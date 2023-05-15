defmodule Inventory.PurchasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Inventory.Purchases` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        id: 42,
        quantity: 42,
        unit_price: 120.5
      })
      |> Inventory.Purchases.create_order()

    order
  end
end
