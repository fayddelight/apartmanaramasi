defmodule ElixirJobs.Repo.Migrations.AddEnumsToOffers do
  use Ecto.Migration

  def up do
    alter table(:offers) do
      add(:district, :string, null: false)
      add(:flat_type, :string, null: false)
    end
  end

  def down do
    alter table(:offers) do
      remove(:district)
      remove(:flat_type)
    end
  end
end
