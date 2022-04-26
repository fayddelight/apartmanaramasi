defmodule ElixirJobs.Repo.Migrations.NormaliseEnumFields do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      modify(:district, :string, null: false)
      modify(:flat_type, :string, null: false)
    end

    Ecto.Migration.execute("DROP TYPE IF EXISTS district")
    Ecto.Migration.execute("DROP TYPE IF EXISTS flat_type")
  end
end
