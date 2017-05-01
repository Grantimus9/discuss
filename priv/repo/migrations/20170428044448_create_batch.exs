defmodule Discuss.Repo.Migrations.CreateBatch do
  use Ecto.Migration

  def change do
    create table(:batches) do
      add :csv_file_url, :string
      add :csv_file_name, :string
      add :job_id, references(:jobs)

      timestamps()
    end

  end
end
