defmodule Discuss.HtaskController do
  use Discuss.Web, :controller

  alias Discuss.Htask

  def index(conn, _params) do
    htasks = Repo.all(Htask)
    render(conn, "index.html", htasks: htasks)
  end

  def new(conn, _params) do
    changeset = Htask.changeset(%Htask{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"htask" => htask_params}) do
    changeset = Htask.changeset(%Htask{}, htask_params)

    case Repo.insert(changeset) do
      {:ok, _htask} ->
        conn
        |> put_flash(:info, "Htask created successfully.")
        |> redirect(to: htask_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    htask = Repo.get!(Htask, id)
    changeset = Htask.submit_work_changeset(%Htask{})
    action = htask_path(conn, :submit_work, htask)
    render(conn, "show.html", htask: htask, changeset: changeset, action: action)
  end

  # def update(conn, %{"id" => id, "htask" => htask_params}) do
  #   htask = Repo.get!(Htask, id)
  #   changeset = Htask.changeset(htask, htask_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, htask} ->
  #       conn
  #       |> put_flash(:info, "Htask updated successfully.")
  #       |> redirect(to: htask_path(conn, :show, htask))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", htask: htask, changeset: changeset)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    htask = Repo.get!(Htask, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(htask)

    conn
    |> put_flash(:info, "Htask deleted successfully.")
    |> redirect(to: htask_path(conn, :index))
  end

  # Handle situation where the text field returned is unanswerable.
  def submit_work(conn, %{"id" => id, "htask" => %{"output" => "unanswerable"}}) do
    htask = Repo.get!(Htask, id)
    changeset = Htask.changeset(htask, %{"output" => "unanswerable"})

    case Repo.update(changeset) do
      {:ok, htask} ->
        conn
        |> put_flash(:info, "Marked Unanswerable")
        |> redirect(to: htask_path(conn, :index))
      {:error, changeset} ->
        render(conn, "show.html", htask: htask, changeset: changeset)
    end

  end

  # Accept string data submissions here.
  def submit_work(conn, %{"id" => id, "htask" => htask_params}) do
    htask = Repo.get!(Htask, id)
    response = htask_params["output"]

    changeset = Htask.changeset(htask, htask_params)

    case Repo.update(changeset) do
      {:ok, htask} ->
        conn
        |> put_flash(:info, "Your Response: #{response}")
        |> redirect(to: htask_path(conn, :index))
      {:error, changeset} ->
        render(conn, "show.html", htask: htask, changeset: changeset)
    end
  end

  




end
