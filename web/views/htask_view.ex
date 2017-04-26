defmodule Discuss.HtaskView do
  use Discuss.Web, :view

  def htask_inputs(map = %{}) do
    inspect(map)
  end

  def htask_inputs(nil) do
    "none"
  end

  def htask_question(map = %{}, string) do
    string
    |> String.replace(~r/\[\[my_key\]\]/, "inserted")

    map
    |> Map.keys
    |> Enum.map(fn(x) -> to_string(x) end)
    # list of keys as strings.
    |> Enum.map(String.replace(~r/\[\[key\]\]/, "inserted"))

  end



end
