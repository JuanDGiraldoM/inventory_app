defmodule Inventory.Purchases.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inventory.Accounts.User
  alias Inventory.Products.Item

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "purchases" do
    field :amount, :decimal
    field :quantity, :integer
    field :unit_price, :decimal

    belongs_to :user, User
    belongs_to :item, Item

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:quantity, :user_id, :item_id, :unit_price, :amount])
    |> validate_required([:quantity, :user_id, :item_id])
    |> validate_number(:quantity, greater_than: 0, message: "Quantity must be greater than 0")
    |> foreign_key_constraint(:user_id, message: "User must exist")
    |> foreign_key_constraint(:item_id, message: "Product must exist")
  end
end
