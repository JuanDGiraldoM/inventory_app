defmodule Inventory.Products.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inventory.Purchases.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :name, :string
    field :quantity, :integer
    field :unit_price, :float

    has_many :purchases, Order

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :quantity, :unit_price])
    |> validate_required([:name, :description, :quantity, :unit_price])
    |> validate_length(:name, max: 20, message: "Name must be at most 20 characters")
    |> validate_length(:description,
      max: 100,
      message: "Description must be at most 100 characters"
    )
    |> validate_number(:quantity,
      greater_than_or_equal_to: 0,
      message: "Quantity must be greater than or equal to 0"
    )
    |> validate_number(:unit_price,
      greater_than_or_equal_to: 0,
      message: "Unit price must be greater than or equal to 0"
    )
    |> unique_constraint(:name, message: "Product already exists")
  end
end
