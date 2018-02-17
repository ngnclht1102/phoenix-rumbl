defmodule Rumbl.Auth do
    import Plug.Conn
    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    def init(opts) do
        Keyword.fetch!(opts, :repo)
    end

    def call(conn, repo) do
        user_id = get_session(conn, :user_id)
        user = user_id && repo.get(Rumbl.User, user_id)
        assign(conn, :current_user, user)
    end

    def login(conn, user) do
        conn 
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
    end

    def logout(conn, _opts) do
        conn
            |> configure_session(drop: true)
    end

    def login_with_user_name_and_password(conn, username, password, _opts) do
        repo = Keyword.fetch!(_opts, :repo)
        user = repo.get_by(Rumbl.User, username: username)

        cond do 
            user && checkpw(password, user.password_hash)
                -> { :ok, login(conn, user) }
            user
                -> { :error, :unauthorized, conn }
            true -> { :error, :unauthorized, conn }
        end
    end

end