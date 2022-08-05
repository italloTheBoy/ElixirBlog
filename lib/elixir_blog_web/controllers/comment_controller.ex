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

  def create(conn, %{"comment" => %{"text" => text, "post_id" => post_id}}) do
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

  def delete(conn, %{"post_id" => post_id, "id" => comment_id}) do
    redirect_if_err = fn conn, post_id ->
      conn
      |> put_flash(:error, "Ocorreu um erro inesperado")
      |> redirect(to: Routes.post_path(conn, :show, post_id))
    end

    %{current_user: current_user} = conn.assigns

    case get_comment(comment_id, [:user, :post]) do
      %Comment{} = comment ->
        if comment.user.id == current_user.id do
          delete_comment(comment)

          conn
          |> put_flash(:info, "Comentario apagado")
          |> redirect(to: Routes.post_path(conn, :show, comment.post.id))
        else
          redirect_if_err.(conn, post_id)
        end

      _ ->
        redirect_if_err.(conn, post_id)
    end
  end
end
