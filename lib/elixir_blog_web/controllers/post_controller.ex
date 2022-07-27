defmodule ElixirBlogWeb.PostController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Post

  def show(conn, %{"id" => id}) do
    post = get_post!(id)

    like_type =
      conn.assigns.current_user.id
      |> get_like_type(post.id)

    render(conn, "show.html", post: post, like_type: like_type)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    user = conn.assigns.current_user

    %{
      text: post_params["text"],
      user_id: user.id
    }
    |> create_post()
    |> case do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created")
        |> redirect(to: Routes.perfil_path(conn, :index, user.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
