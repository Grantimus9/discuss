# defmodule Discuss.HtaskControllerTest do
#   use Discuss.ConnCase
#
#   alias Discuss.Htask
#   @valid_attrs %{inputs: %{}, output: "some content"}
#   @invalid_attrs %{}
#
#   test "lists all entries on index", %{conn: conn} do
#     conn = get conn, htask_path(conn, :index)
#     assert html_response(conn, 200) =~ "Listing htasks"
#   end
#
#   test "renders form for new resources", %{conn: conn} do
#     conn = get conn, htask_path(conn, :new)
#     assert html_response(conn, 200) =~ "New htask"
#   end
#
#   test "creates resource and redirects when data is valid", %{conn: conn} do
#     conn = post conn, htask_path(conn, :create), htask: @valid_attrs
#     assert redirected_to(conn) == htask_path(conn, :index)
#     assert Repo.get_by(Htask, @valid_attrs)
#   end
#
#   test "does not create resource and renders errors when data is invalid", %{conn: conn} do
#     conn = post conn, htask_path(conn, :create), htask: @invalid_attrs
#     assert html_response(conn, 200) =~ "New htask"
#   end
#
#   test "shows chosen resource", %{conn: conn} do
#     htask = Repo.insert! %Htask{}
#     conn = get conn, htask_path(conn, :show, htask)
#     assert html_response(conn, 200) =~ "Show htask"
#   end
#
#   test "renders page not found when id is nonexistent", %{conn: conn} do
#     assert_error_sent 404, fn ->
#       get conn, htask_path(conn, :show, -1)
#     end
#   end
#
#   test "renders form for editing chosen resource", %{conn: conn} do
#     htask = Repo.insert! %Htask{}
#     conn = get conn, htask_path(conn, :edit, htask)
#     assert html_response(conn, 200) =~ "Edit htask"
#   end
#
#   test "updates chosen resource and redirects when data is valid", %{conn: conn} do
#     htask = Repo.insert! %Htask{}
#     conn = put conn, htask_path(conn, :update, htask), htask: @valid_attrs
#     assert redirected_to(conn) == htask_path(conn, :show, htask)
#     assert Repo.get_by(Htask, @valid_attrs)
#   end
#
#   test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
#     htask = Repo.insert! %Htask{}
#     conn = put conn, htask_path(conn, :update, htask), htask: @invalid_attrs
#     assert html_response(conn, 200) =~ "Edit htask"
#   end
#
#   test "deletes chosen resource", %{conn: conn} do
#     htask = Repo.insert! %Htask{}
#     conn = delete conn, htask_path(conn, :delete, htask)
#     assert redirected_to(conn) == htask_path(conn, :index)
#     refute Repo.get(Htask, htask.id)
#   end
# end
