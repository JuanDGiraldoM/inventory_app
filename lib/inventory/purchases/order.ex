defmodule Inventory.Purchases.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :amount, :float
    field :quantity, :integer
    field :unit_price, :float
    field :user_id, :binary_id
    field :product_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:quantity, :unit_price, :amount])
    |> validate_required([:quantity, :unit_price, :amount])
    |> validate_number(:quantity, greater_than: 0, message: "Quantity must be greater than 0")
    |> validate_number(:unit_price, greater_than: 0, message: "Unit price must be greater than 0")
    |> validate_number(:amount, greater_than: 0, message: "Amount must be greater than 0")
    |> foreign_key_constraint(:user_id, message: "User must exist")
    |> foreign_key_constraint(:product_id, message: "Product must exist")
  end
end
