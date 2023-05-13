defmodule Inventory.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :quantity, :integer
      add :unit_price, :float

      timestamps()
    end

    create unique_index(:products, [:name])
  end
end
