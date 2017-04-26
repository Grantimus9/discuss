# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Discuss.Repo.insert!(%Discuss.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Discuss.Repo


Repo.insert!(%Discuss.Htask{
  inputs: %{
    "name" => "Carl Sanders",
    "state" => "DC",
    "title" => "Mr."
  },
  output: "123456789"
  })
