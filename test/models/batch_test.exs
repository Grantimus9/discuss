defmodule Discuss.BatchTest do
  use Discuss.ModelCase

  alias Discuss.Batch

  @valid_attrs %{csv_file_name: "some content", csv_file_url: "a_url", job_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Batch.changeset(%Batch{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Batch.changeset(%Batch{}, @invalid_attrs)
    refute changeset.valid?
  end
end
