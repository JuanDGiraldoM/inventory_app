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
      map_from_list(
        [order.item],
        fn item ->
          %{
            id: item.id,
            name: item.name,
            description: item.description
          }
        end
      )

    user =
      map_from_list(
        [order.user],
        fn user ->
          %{
            id: user.id,
            name: user.name,
            lastname: user.lastname
          }
        end
      )

    %{
      id: order.id,
      quantity: order.quantity,
      unit_price: order.unit_price,
      amount: order.amount,
      item: item,
      user: user
    }
  end

  defp map_from_list(list, fun) when is_list(list) and is_function(fun) do
    list
    |> Enum.map(&Map.from_struct/1)
    |> Enum.map(fun)
    |> List.first()
  end

  defp map_from_list(_, _) do
    %{}
  end
end
