defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  alias Rumbl.User
  


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{ "session" => %{ "username" => username, "password" => password }}) do
      result = Rumbl.Auth.login_with_user_name_and_password(conn, username, password, repo: Repo)
      case result do
        { :ok, connn } -> connn
              |> put_flash(:info, "Welcome")
              |> redirect(to: user_path(conn, :index))
        { :error, reason,  connn }-> connn
              |> put_flash(:error, "Error #{reason}")
              |> redirect(to: session_path(conn, :new))

      end  
  end

  def delete(conn, _params) do
    conn
     |> Rumbl.Auth.logout
     |> redirect(to: page_path(conn, :index))
            
  end

end
