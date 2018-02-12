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
    user = Repo.get_by User, id: id
    IO.inspect user
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{} )
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{ "user" => user_param}) do
      changeset = User.changeset(%User{}, user_param)
        IO.inspect changeset
      case Repo.insert changeset do
          {:ok, user} -> 
            conn
             |> put_flash(:info, "#{user.name} created")
             |> redirect(to: user_path(conn, :index))
          {:error, changeset} -> 
             render conn, "new.html", changeset: changeset
      end
  end

end
