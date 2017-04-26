defmodule Discuss.Htask do
  use Discuss.Web, :model

  schema "htasks" do
    field :inputs, :map
    field :output, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:inputs, :output])
    |> validate_required([:inputs, :output])
  end
end
