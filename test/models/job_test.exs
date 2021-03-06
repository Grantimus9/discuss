defmodule Discuss.JobTest do
  use Discuss.ModelCase

  alias Discuss.Job

  @valid_attrs %{name: "some content", question_string: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, @invalid_attrs)
    refute changeset.valid?
  end
end
