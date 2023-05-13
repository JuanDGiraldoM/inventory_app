defmodule Inventory.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :age, :integer
    field :balance, :float
    field :lastname, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :age, :balance])
    |> validate_required([:name, :lastname, :age, :balance])
    |> validate_length(:name, max: 20, message: "Name must be at most 20 characters")
    |> validate_length(:lastname, max: 20, message: "Lastname must be at most 20 characters")
    |> validate_number(:age, greater_than: 18, message: "Age must be greater than 18")
    |> validate_number(:balance,
      greater_than_or_equal_to: 0,
      message: "Balance must be greater than or equal to 0"
    )
    |> unique_constraint([:name, :lastname], message: "User already exists")
  end
end
