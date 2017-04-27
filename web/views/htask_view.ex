defmodule Discuss.HtaskView do
  use Discuss.Web, :view

  def htask_inputs(map = %{}) do
    inspect map
  end

  def htask_inputs(nil) do
    "none"
  end

  def htask_question(map = %{}, string) do
    replace_with_value(map, string, Map.keys(map))
  end

  def replace_with_value(map = %{}, string, []), do: string # return string if the list of keys is empty.
  def replace_with_value(map = %{}, string, [key | map_keys]) do
    string = String.replace(string, ~r/\[\[#{key}\]\]/, map["#{key}"])
    replace_with_value(map, string, map_keys)
  end


end
