defmodule InventoryWeb.ItemJSON do
  alias Inventory.Products.Item

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{data: for(item <- products, do: data(item))}
  end

  @doc """
  Renders a single item.
  """
  def show(%{item: item}) do
    %{data: data(item)}
  end

  defp data(%Item{} = item) do
    %{
      id: item.id,
      name: item.name,
      description: item.description,
      stock: item.quantity,
      unit_price: item.unit_price
    }
  end
end
