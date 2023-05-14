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
    item =
      if is_map(order.item) do
        [order.item]
        |> Enum.map(&Map.from_struct/1)
        |> Enum.map(fn item ->
          %{
            id: item.id,
            name: item.name,
            description: item.description
          }
        end)
        |> List.first()
      else
        %{}
      end

    user =
      if is_map(order.user) do
        [order.user]
        |> Enum.map(&Map.from_struct/1)
        |> Enum.map(fn user ->
          %{
            id: user.id,
            name: user.name,
            lastname: user.lastname
          }
        end)
        |> List.first()
      else
        %{}
      end

    %{
      id: order.id,
      quantity: order.quantity,
      unit_price: order.unit_price,
      amount: order.amount,
      item: item,
      user: user
    }
  end
end
