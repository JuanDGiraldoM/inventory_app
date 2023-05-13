defmodule InventoryWeb.ItemController do
  use InventoryWeb, :controller

  alias Inventory.Products
  alias Inventory.Products.Item

  action_fallback InventoryWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Products.create_item(item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/products/#{item}")
      |> render(:show, item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Products.get_item!(id)
    render(conn, :show, item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Products.get_item!(id)

    with {:ok, %Item{} = item} <- Products.update_item(item, item_params) do
      render(conn, :show, item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Products.get_item!(id)

    with {:ok, %Item{}} <- Products.delete_item(item) do
      send_resp(conn, :no_content, "")
    end
  end
end
