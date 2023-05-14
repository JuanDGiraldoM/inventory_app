defmodule InventoryWeb.UserJSON do
  alias Inventory.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    IO.inspect(user)

    purchases =
      if is_list(user.purchases) do
        user.purchases
        |> Enum.map(&Map.from_struct/1)
        |> Enum.map(fn purchase ->
          %{
            id: purchase.id,
            quantity: purchase.quantity,
            unit_price: purchase.unit_price,
            amount: purchase.amount
          }
        end)
      else
        []
      end

    %{
      id: user.id,
      name: user.name,
      lastname: user.lastname,
      age: user.age,
      balance: user.balance,
      purchases: purchases
    }
  end
end
