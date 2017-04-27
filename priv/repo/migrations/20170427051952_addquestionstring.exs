defmodule Discuss.Repo.Migrations.Addquestionstring do
  use Ecto.Migration

  def change do
    alter table(:htasks) do
      add :question_string, :string
    end
  end
end
