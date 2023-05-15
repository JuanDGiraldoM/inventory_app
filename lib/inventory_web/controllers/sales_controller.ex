defmodule InventoryWeb.SalesController do
  use InventoryWeb, :controller

  alias Inventory.Purchases

  action_fallback InventoryWeb.FallbackController

  def index(conn, _params) do
    orders = Purchases.list_orders()
    render(conn, :index, orders: orders)
  end
end
