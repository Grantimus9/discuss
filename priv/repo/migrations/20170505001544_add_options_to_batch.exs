defmodule Discuss.Repo.Migrations.AddOptionsToBatch do
  use Ecto.Migration

  def change do
    alter table(:batches) do
      add :unique_submissions_requirement, :integer, default: 3
      add :reward_per_submission, :integer, default: 1
    end
  end
end
