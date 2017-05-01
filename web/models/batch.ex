defmodule Discuss.Batch do
  use Discuss.Web, :model

  schema "batches" do
    field :csv_file_url, :string
    field :csv_file_name, :string
    field :job_id, :integer

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
end
