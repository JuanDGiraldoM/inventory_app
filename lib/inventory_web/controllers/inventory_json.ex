defmodule InventoryWeb.InventoryJSON do
  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    products_resume =
      products
      |> Enum.reduce(%{}, fn product, acc ->
        Map.put(acc, product.name, %{
          quantity: product.quantity,
          amount: Decimal.mult(product.unit_price, product.quantity)
        })
      end)

    total =
      products
      |> Enum.reduce(Decimal.new("0"), fn product, acc ->
        Decimal.add(acc, Decimal.mult(product.unit_price, product.quantity))
      end)

    response = %{
      products: products_resume,
      total: total
    }

    %{inventory: response}
  end
end
