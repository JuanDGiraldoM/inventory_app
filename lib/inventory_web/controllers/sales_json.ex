defmodule InventoryWeb.SalesJSON do
  @doc """
  Renders a list of products.
  """
  def index(%{orders: orders}) do
    product_sales =
      orders
      |> Enum.reduce(%{}, fn order, acc ->
        cond do
          Map.has_key?(acc, order.item.name) ->
            Map.put(acc, order.item.name, %{
              quantity: order.quantity + acc[order.item.name].quantity,
              amount: Decimal.add(order.amount, acc[order.item.name].amount)
            })

          true ->
            Map.put(acc, order.item.name, %{
              quantity: order.quantity,
              amount: order.amount
            })
        end
      end)
      |> IO.inspect()

    total =
      orders
      |> Enum.reduce(Decimal.new("0"), fn order, acc ->
        Decimal.add(acc, order.amount)
      end)

    response = %{
      products: product_sales,
      total: total
    }

    %{sales: response}
  end
end
