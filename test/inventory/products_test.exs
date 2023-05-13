defmodule Inventory.ProductsTest do
  use Inventory.DataCase

  alias Inventory.Products

  describe "products" do
    alias Inventory.Products.Item

    import Inventory.ProductsFixtures

    @invalid_attrs %{description: nil, name: nil, quantity: nil, unit_price: nil}

    test "list_products/0 returns all products" do
      item = item_fixture()
      assert Products.list_products() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Products.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{
        description: "some description",
        name: "some name",
        quantity: 42,
        unit_price: 120.5
      }

      assert {:ok, %Item{} = item} = Products.create_item(valid_attrs)
      assert item.description == "some description"
      assert item.name == "some name"
      assert item.quantity == 42
      assert item.unit_price == 120.5
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name",
        quantity: 43,
        unit_price: 456.7
      }

      assert {:ok, %Item{} = item} = Products.update_item(item, update_attrs)
      assert item.description == "some updated description"
      assert item.name == "some updated name"
      assert item.quantity == 43
      assert item.unit_price == 456.7
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_item(item, @invalid_attrs)
      assert item == Products.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Products.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Products.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Products.change_item(item)
    end
  end
end
