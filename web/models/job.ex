defmodule Discuss.Job do
  use Discuss.Web, :model

  schema "jobs" do
    field :name, :string
    field :question_string, :string
    has_many :batches, Discuss.Batch

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :question_string])
    |> validate_required([:name, :question_string])
  end
end
