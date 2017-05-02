defmodule Discuss.BatchController do
  use Discuss.Web, :controller

  alias Discuss.{Batch, Csvfile}

  def index(conn, _params) do
    batches = Repo.all(Batch)
    render(conn, "index.html", batches: batches)
  end

  def new(conn, _params) do
    changeset = Batch.changeset(%Batch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"batch" => batch_params}) do
    changeset = Batch.changeset(%Batch{}, batch_params)

    # 1. stash file
    Discuss.Uploaders.BatchCsvfile.upload(batch_params["csv_file"])

    # 2. with stashed file data, create db entry.
    # 3. if either of the above fails, return error


    case Repo.insert(changeset) do
      {:ok, batch} ->

        conn
        |> put_flash(:info, "Batch created successfully.")
        |> redirect(to: batch_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    batch = Repo.get!(Batch, id)
    render(conn, "show.html", batch: batch)
  end

  def edit(conn, %{"id" => id}) do
    batch = Repo.get!(Batch, id)
    changeset = Batch.changeset(batch)
    render(conn, "edit.html", batch: batch, changeset: changeset)
  end

  def update(conn, %{"id" => id, "batch" => batch_params}) do
    batch = Repo.get!(Batch, id)
    changeset = Batch.changeset(batch, batch_params)

    case Repo.update(changeset) do
      {:ok, batch} ->
        conn
        |> put_flash(:info, "Batch updated successfully.")
        |> redirect(to: batch_path(conn, :show, batch))
      {:error, changeset} ->
        render(conn, "edit.html", batch: batch, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    batch = Repo.get!(Batch, id)

    IO.inspect batch.csv_file

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(batch)

    conn
    |> put_flash(:info, "Batch deleted successfully.")
    |> redirect(to: batch_path(conn, :index))
  end
end
