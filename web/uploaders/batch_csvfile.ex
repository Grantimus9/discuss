defmodule Discuss.Uploaders.BatchCsvfile do
  # Uploads CSV File to S3.
  # Accepts a %Plug.Upload{} Struct and returns the URL of the S3 object created.


  defstruct filename: "", bucket: "", binary: nil, url: nil

  # Set the whitelist of extensions here.
  @extension_whitelist ~w(.csv)

  def set_filename(struct) do
    uuid = Ecto.UUID.generate()
    filename = uuid <> "-" <> struct.filename

    struct
    |> Map.merge(%{filename: filename})
  end

  def set_bucket(struct) do
    struct |> Map.merge(%{bucket: s3_bucket})
  end

  # # Check the extension. Throw error on failure.
  def validate_extension(struct) do
    file_extension = struct.filename
      |> Path.extname()
      |> String.downcase()

    if Enum.member?(@extension_whitelist, file_extension) do
      struct
    else
      {:error, "Invalid File Extension"}
    end
  end

  def set_binary(struct) do
    {:ok, file_binary } = File.read(struct.path)

    struct
    |> Map.merge(%{binary: file_binary})
  end

  def upload(upload_plug_struct) do

    finished_struct = upload_plug_struct
      |> to_struct
      |> set_filename
      |> validate_extension
      |> set_binary
      |> set_bucket

    IO.inspect finished_struct

    {:ok, _} = ExAws.S3.put_object(s3_bucket, finished_struct.filename, finished_struct.binary)
                |> ExAws.request

  end

  def to_struct(upload_plug_struct) do
    %Discuss.Uploaders.BatchCsvfile{}
    |> Map.merge(upload_plug_struct)
  end

  def s3_bucket do
    System.get_env("AWS_S3_BUCKET")
  end

end
