defmodule Inventory.PurchasesTest do
  use Inventory.DataCase

  alias Inventory.Purchases

  describe "orders" do
    alias Inventory.Purchases.Order

    import Inventory.PurchasesFixtures

    @invalid_attrs %{amount: nil, id: nil, quantity: nil, unit_price: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Purchases.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Purchases.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{amount: 120.5, id: 42, quantity: 42, unit_price: 120.5}

      assert {:ok, %Order{} = order} = Purchases.create_order(valid_attrs)
      assert order.amount == 120.5
      assert order.quantity == 42
      assert order.unit_price == 120.5
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Purchases.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{amount: 456.7, id: 43, quantity: 43, unit_price: 456.7}

      assert {:ok, %Order{} = order} = Purchases.update_order(order, update_attrs)
      assert order.amount == 456.7
      assert order.quantity == 43
      assert order.unit_price == 456.7
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Purchases.update_order(order, @invalid_attrs)
      assert order == Purchases.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Purchases.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Purchases.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Purchases.change_order(order)
    end
  end
end
