defmodule Discuss.Repo.Migrations.CreateHtask do
  use Ecto.Migration

  def change do
    create table(:htasks) do
      add :inputs, :map
      add :output, :string

      timestamps()
    end

  end
end
