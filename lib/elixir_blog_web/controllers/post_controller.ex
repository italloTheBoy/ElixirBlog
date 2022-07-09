defmodule ElixirBlogWeb.PostController do
  use ElixirBlogWeb, :controller
  import ElixirBlog.Timeline
  alias ElixirBlog.Timeline.Post

  def index(conn, %{}) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    IO.inspect(conn.assigns.current_user.id)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    IO.inspect(post_params)

    case create_post(post_params) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created")
        |> redirect(to: Routes.post_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

    end
    render(conn, "index.html")
  end
end
