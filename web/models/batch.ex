defmodule Discuss.Batch do
  use Discuss.Web, :model
  use Arc.Ecto.Model

  schema "batches" do
    field :csv_file, Discuss.Csvfile.Type
    field :job_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:csv_file, :job_id])
    |> validate_required([:csv_file, :job_id])
  end
end
