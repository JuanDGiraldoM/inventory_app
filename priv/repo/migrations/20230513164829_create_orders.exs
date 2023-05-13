defmodule Inventory.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :unit_price, :float
      add :amount, :float
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:orders, [:user_id])
    create index(:orders, [:product_id])
  end
end
