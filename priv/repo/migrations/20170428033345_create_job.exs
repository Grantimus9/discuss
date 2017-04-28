defmodule Discuss.Repo.Migrations.CreateJob do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :name, :string
      add :question_string, :string

      timestamps()
    end

  end
end
