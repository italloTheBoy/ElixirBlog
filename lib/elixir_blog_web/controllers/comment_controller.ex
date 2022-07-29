defmodule ElixirBlogWeb.CommentController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Comment

  def new(conn, _params) do
    changeset = Comment.changeset(%Comment{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    user = conn.assigns.current_user

    %{
      text: comment_params.text,
      post_id: comment_params.post_id,
      user_id: user.id,
    }
    |> create_comment()
    |> case do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Post comentado")
        |> redirect(to: Routes.post_path(conn, :show, comment_params.post_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
