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

    #    products_resume =
    #      products
    #      |> Enum.reduce(%{}, fn product, acc ->
    #        Map.put(acc, product.name, %{
    #          quantity: product.quantity,
    #          amount: Decimal.mult(product.unit_price, product.quantity)
    #        })
    #      end)
    #
    #    total =
    #      products
    #      |> Enum.reduce(Decimal.new("0"), fn product, acc ->
    #        Decimal.add(acc, Decimal.mult(product.unit_price, product.quantity))
    #      end)
    #
    response = %{
      products: product_sales,
      total: total
    }

    %{sales: response}
  end
end
