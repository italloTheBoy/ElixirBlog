defmodule ElixirBlogWeb.CommentController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Comment

  def new(conn, %{"post_id" => post_id}) do
    changeset = Comment.changeset(%Comment{})

    render(conn, "new.html",
      changeset: changeset,
      post_id: post_id
    )
  end

  def create(conn, %{ "comment" => %{"text" => text, "post_id" => post_id} }) do
    %{id: user_id} = conn.assigns.current_user

    params = %{
      text: text,
      post_id: post_id,
      user_id: user_id
    }

    case create_comment(params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Post comentado")
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          post_id: post_id
        )
    end
  end

  def delete(conn, %{"id" => comment_id}) do
    comment = get_comment(comment_id, [:user, :post])

    case comment do
      %Comment{} ->
    end

    %Comment{user: user, post: post}

    [current_user: current_user] = conn.assigns

    if current_user.id == user.id do
      delete_comment(comment)

      conn
      |> put_flash(:info, "Comentario apagado")
      |> redirect(to: Routes.post_path(conn, :show, post.id))
    else
      conn
      |> put_flash(:error, "Ocorreu um erro inesperado")
      |> redirect(to: Routes.post_path(conn, :show, post.id))
    end
  end
end
