defmodule InventoryWeb.OrderJSON do
  alias Inventory.Purchases.Order

  @doc """
  Renders a list of orders.
  """
  def index(%{orders: orders}) do
    %{data: for(order <- orders, do: data(order))}
  end

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

  defp data(%Order{} = order) do
    %{
      id: order.id,
      quantity: order.quantity,
      unit_price: order.unit_price,
      amount: order.amount
    }
  end
end
