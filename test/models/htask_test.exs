defmodule Discuss.HtaskTest do
  use Discuss.ModelCase

  alias Discuss.Htask

  @valid_attrs %{inputs: %{}, output: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Htask.changeset(%Htask{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Htask.changeset(%Htask{}, @invalid_attrs)
    refute changeset.valid?
  end


end
