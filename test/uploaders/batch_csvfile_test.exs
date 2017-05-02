defmodule Discuss.Uploaders.BatchCsvfileTest do
  use Discuss.ConnCase

  alias Discuss.Uploaders.BatchCsvfile

  test "Merging in a %Plug.Upload struct works" do
    plugstruct = %Plug.Upload{content_type: "text/csv", filename: "test.csv",
      path: "/tmp/plug-1493/multipart-618827-39427-2"}

    assert BatchCsvfile.to_struct(plugstruct)
  end

  test "Setting Filename" do
    struct = %BatchCsvfile{filename: "upload.csv"}

    assert BatchCsvfile.set_filename(struct)
  end

  test "Allows CSV file extension" do
    struct = %BatchCsvfile{filename: "upload.csv"}
      |> BatchCsvfile.validate_extension

    refute {:error, "Invalid File Extension"} == struct
  end

  test "Prohibits .jpg file extensions" do
    struct = %BatchCsvfile{filename: "upload.jpg"}
      |> BatchCsvfile.validate_extension

    assert {:error, "Invalid File Extension"} == struct
  end




end
