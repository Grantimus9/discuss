

defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller
  @moduledoc """
    Finds and sets a user.
  """
  alias Discuss.Repo
  alias Discuss.User

  # No setup required.
  def init(_params) do
  end

  # All logic goes in here.
  def call(conn, _params_from_init_function) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end

end
