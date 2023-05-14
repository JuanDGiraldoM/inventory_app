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
    purchases =
      map_from_list(
        user.purchases,
        fn purchase ->
          %{
            id: purchase.id,
            quantity: purchase.quantity,
            unit_price: purchase.unit_price,
            amount: purchase.amount
          }
        end
      )

    %{
      id: user.id,
      name: user.name,
      lastname: user.lastname,
      age: user.age,
      balance: user.balance,
      purchases: purchases
    }
  end

  defp map_from_list(list, fun) when is_list(list) and is_function(fun) do
    list
    |> Enum.map(&Map.from_struct/1)
    |> Enum.map(fun)
  end

  defp map_from_list(_, _) do
    []
  end
end
