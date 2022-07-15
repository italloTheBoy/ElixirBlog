defmodule ElixirBlogWeb.PostController do
  use ElixirBlogWeb, :controller
  import ElixirBlog.Timeline
  alias ElixirBlog.Timeline.Post

  def show(conn, %{"id" => id}) do
    post = get_post!(id)

    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset, errs: [])
  end

  def create(conn, %{"post" => post_params}) do
    %{
      text: post_params["text"],
      user_id: conn.assigns.current_user.id
    }
    |> create_post()
    |> case do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created")
        |> redirect(to: Routes.post_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
