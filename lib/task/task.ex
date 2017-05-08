

defmodule Discuss.Task do
  @moduledoc """
    Functions related to a task/htask.
  """
  alias Discuss.Htask



  # Takes a batch, creates appropriate number of htasks,
  # then returns a tuple with status.
  def publish(batch) do
    IO.inspect batch


  end




  # Given CSV, stream it row-map-by-row-map to
  # a function that creates the correct number of
  # htasks.


  def create_htasks(row_map, 0), do: nil
  def create_htasks(row_map, number) do
    params = %{
      inputs: row_map,
      output: "",
      question_string: ""
    }
    changeset = Htask.changeset(%Htask{}, params)
  end


end
