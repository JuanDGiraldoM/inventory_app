defmodule Inventory.Purchases do
  @moduledoc """
  The Purchases context.
  """

  import Ecto.Query, warn: false
  alias Inventory.Repo
  alias Inventory.Products
  alias Inventory.Accounts
  alias Inventory.Purchases.Order

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order) |> Repo.preload([:user, :item])
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id) |> Repo.preload(:item)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    item = Products.check_stock!(attrs["item_id"], attrs["quantity"])

    case item do
      {:error, message} ->
        {:error, message}

      %{unit_price: unit_price} ->
        total = Decimal.mult(attrs["quantity"], unit_price)
        user = Accounts.check_balance!(attrs["user_id"], total)

        case user do
          {:error, message} ->
            {:error, message}

          _ ->
            Accounts.update_balance(user, Decimal.negate(total))
            Products.update_stock(item, -attrs["quantity"])

            new_attrs =
              Map.put(attrs, "unit_price", unit_price)
              |> Map.put("amount", total)

            %Order{}
            |> Order.changeset(new_attrs)
            |> Repo.insert()
        end
    end
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end
end
