defmodule Discuss.Batch do
  use Discuss.Web, :model

  schema "batches" do
    field :csv_file_url, :string
    field :csv_file_name, :string
    field :unique_submissions_requirement, :integer
    field :reward_per_submission, :integer
    belongs_to :job, Discuss.Job

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:csv_file_url, :csv_file_name, :job_id])
    |> validate_required([:csv_file_url, :csv_file_name, :job_id])
  end

  # Options page changeset defining particulars of this batch.
  def options_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:unique_submissions_requirement, :reward_per_submission])
    |> validate_required([:unique_submissions_requirement, :reward_per_submission])
  end
end
