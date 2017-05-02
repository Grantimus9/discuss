defmodule Discuss.Uploaders.BatchCsvfile do
  # Uploads CSV File to S3.
  # Accepts a %Plug.Upload{} Struct and returns the URL of the S3 object created.


  defstruct filename: nil, binary: nil, url: nil, path: nil

  # Set the whitelist of extensions here.
  @extension_whitelist ~w(.csv)

  # Set the S3 Base URL:
  @s3_url "https://s3.amazonaws.com/" <> System.get_env("AWS_S3_BUCKET") <> "/"


  def set_filename(struct) do
    uuid = Ecto.UUID.generate()
    filename = uuid <> "-" <> struct.filename

    struct
    |> Map.merge(%{filename: filename})
  end

  def set_url(struct) do
    url = @s3_url <> struct.filename
    struct
    |> Map.merge(%{csv_file_url: url})
  end

  # # Check the extension. Throw error on failure.
  def validate_extension(struct) do

    file_extension = struct.filename
      |> Path.extname()
      |> String.downcase()

    if Enum.member?(@extension_whitelist, file_extension) do
      struct
    else
      nil
    end
  end

  def upload(upload_plug_struct) do

    finished_struct = upload_plug_struct
      |> to_struct
      |> set_filename
      |> validate_extension
      |> set_url

    %{status_code: 200} = finished_struct.path
      |> ExAws.S3.Upload.stream_file
      |> ExAws.S3.upload(System.get_env("AWS_S3_BUCKET"), finished_struct.filename)
      |> ExAws.request!

    finished_struct # Return the struct back to get the new S3 URL and filename
  end

  def to_struct(upload_plug_struct) do
    plugmap = upload_plug_struct
      |> Map.from_struct

      %Discuss.Uploaders.BatchCsvfile{}
      |> Map.merge(plugmap)
  end

end
