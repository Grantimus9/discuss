defmodule Discuss.JobController do
  use Discuss.Web, :controller

  alias Discuss.{Job, Batch}

  def index(conn, _params) do
    jobs = Repo.all(Job)
    render(conn, "index.html", jobs: jobs)
  end

  def new(conn, _params) do
    changeset = Job.changeset(%Job{})
    example_string = "Please confirm that [[name]] still likes the color [[favorite_color]]"
    render(conn, "new.html", changeset: changeset, example_string: example_string)
  end

  def create(conn, %{"job" => job_params}) do
    changeset = Job.changeset(%Job{}, job_params)

    case Repo.insert(changeset) do
      {:ok, _job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: job_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Repo.get!(Job, id) |> Repo.preload(:batches)
    batch_changeset = Batch.changeset(%Batch{job_id: id})
    batches = job.batches
    render(conn, "show.html", job: job, batch_changeset: batch_changeset, batches: batches)
  end

  def edit(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)
    example_string = "Please confirm that [[name]] still likes the color [[favorite_color]]"
    changeset = Job.changeset(job)
    render(conn, "edit.html", job: job, changeset: changeset, example_string: example_string)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Repo.get!(Job, id)
    changeset = Job.changeset(job, job_params)

    case Repo.update(changeset) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: job_path(conn, :show, job))
      {:error, changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: job_path(conn, :index))
  end
end
