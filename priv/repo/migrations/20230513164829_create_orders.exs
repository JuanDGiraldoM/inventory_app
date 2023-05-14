defmodule Inventory.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:purchases, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :unit_price, :decimal
      add :amount, :decimal
      add :user_id, references(:accounts, on_delete: :delete_all, type: :binary_id)
      add :item_id, references(:products, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:purchases, [:user_id])
    create index(:purchases, [:item_id])
  end
end
