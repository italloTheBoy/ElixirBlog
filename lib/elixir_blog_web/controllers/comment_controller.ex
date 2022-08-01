defmodule ElixirBlogWeb.CommentController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Comment

  def new(conn, %{"post_id" => post_id} = p) do
    changeset = Comment.changeset(%Comment{})

    render(conn, "new.html", [
      changeset: changeset,
      post_id: post_id
    ])
  end

  def create(conn, %{"comment" => %{"text" => text, "post_id" => post_id}}) do
    %{id: user_id} = conn.assigns.current_user

    params = %{
      text: text,
      post_id: post_id,
      user_id: user_id,
    }

    case create_comment(params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Post comentado")
        |> redirect([
          to: Routes.post_path(conn, :show, post_id)
        ])

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", [
          changeset: changeset,
          post_id: post_id
        ])
    end
  end
end
