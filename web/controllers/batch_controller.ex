defmodule Discuss.BatchController do
  use Discuss.Web, :controller

  alias Discuss.{Batch, Uploaders.BatchCsvfile}

  def index(conn, _params) do
    batches = Repo.all(Batch)
    render(conn, "index.html", batches: batches)
  end

  def new(conn, _params) do
    changeset = Batch.changeset(%Batch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"batch" => batch_params}) do
    # 1. stash file
    %BatchCsvfile{csv_file_url: csv_file_url, filename: csv_file_name } = Discuss.Uploaders.BatchCsvfile.upload(batch_params["csv_file"])

    # 2. with stashed file data, create db entry.
    batch_params = Map.merge(batch_params, %{"csv_file_name" => csv_file_name, "csv_file_url" => csv_file_url})
    changeset = Batch.changeset(%Batch{}, batch_params)

    # 3. if either of the above fails, return error
    case Repo.insert(changeset) do
      {:ok, batch} ->
        conn
        |> put_flash(:info, "Batch created successfully.")
        |> redirect(to: batch_path(conn, :options, batch))
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

    ExAws.S3.delete_object(System.get_env("AWS_S3_BUCKET"), batch.csv_file_name)
    |> ExAws.request!

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(batch)

    conn
    |> put_flash(:info, "Batch deleted successfully.")
    |> redirect(to: batch_path(conn, :index))
  end

  # Options Submission / Form Submission.
  def options(conn, %{"id" => id, "batch" => batch_params}) do
    batch = Repo.get!(Batch, id)
    options_changeset = Batch.options_changeset(batch, batch_params)

    case Repo.update(options_changeset) do
      {:ok, batch} ->
        conn
        |> redirect(to: batch_path(conn, :publish, batch))
      {:error, changeset} ->
        render(conn, "options.html", batch: batch, options_changeset: changeset)
    end
  end

  # Show/Get options.
  def options(conn, %{"id" => id}) do
    batch = Repo.get!(Batch, id)
    options_changeset = Batch.options_changeset(batch)
    conn
    |> render("options.html", batch: batch, options_changeset: options_changeset)
  end

  # POST/put publish authorization.
  def publish(conn, %{"id" => id, "batch" => %{"publish" => true}}) do
    batch = Repo.get!(Batch, id)

    case Discuss.Task.publish(batch) do
      {:ok, _} ->
        conn
        |> redirect(batch_path(conn, :show, batch))
      {:error, _err} ->
          conn
          |> put_flash(:info, "Something Went Wrong With Errors")
          |> redirect(batch_path(conn, :publish, batch))
      _ ->
        conn
        |> put_flash(:info, "Unknown Error")
        |> redirect(batch_path(conn, :publish, batch))
    end

  end

  # Get/show Publish Confirmation Page
  def publish(conn, %{"id" => id}) do
    batch = Repo.get!(Batch, id)

    conn
    |> render("publish.html", batch: batch)
  end



end
