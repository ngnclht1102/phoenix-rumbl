defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  def index(conn, _params) do
    users = Repo.all(User)
    IO.inspect users
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    IO.inspect id
    user = Repo.getBy User, id: id
    IO.inspect user
    render conn, "show.html", user: user
  end
end
