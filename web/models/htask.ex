defmodule Discuss.Htask do
  use Discuss.Web, :model

  schema "htasks" do
    field :inputs, :map
    field :output, :string
    field :question_string, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:inputs, :output, :question_string])
    |> validate_required([:inputs, :output, :question_string])
  end
end
