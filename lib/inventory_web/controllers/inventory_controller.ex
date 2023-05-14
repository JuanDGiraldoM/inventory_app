defmodule InventoryWeb.InventoryController do
  use InventoryWeb, :controller

  alias Inventory.Products

  action_fallback InventoryWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end
end
