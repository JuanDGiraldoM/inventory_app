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
    IO.inspect(order)
    #    item = [order.item]
    #           |> Enum.map(&Map.from_struct/1)
    #           |> Enum.map(fn item ->
    #      %{
    #      id: item.id,
    #        name: item.name,
    #        description: item.description,
    #        price: item.unit_price,
    #        stock: item.quantity}
    #    end)
    %{
      id: order.id,
      user_id: order.user_id,
      item_id: order.item_id,
      quantity: order.quantity,
      unit_price: order.unit_price,
      amount: order.amount
      #      item: item
    }
  end
end
