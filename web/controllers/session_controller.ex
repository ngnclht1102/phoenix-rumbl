defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  alias Rumbl.User
  


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{ "session" => %{ "username" => username, "password" => password }}) do
      case Rumbl.Auth.login_with_user_name_and_password(conn, username, password, repo: Repo) do
        { :ok } -> conn
              |> redirect(to: user_path(conn, :index))
        _-> conn
              |> IO.inspect
              |> put_flash(:info, "Error")
              |> redirect(to: session_path(conn, :new))

      end  
  end

  def delete(conn, _params) do
    conn
     |> Rumbl.Auth.logout
     |> redirect(to: page_path(conn, :index))
            
  end

end
