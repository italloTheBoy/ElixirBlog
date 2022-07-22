defmodule ElixirBlogWeb.LikeController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Like

  def create(conn, %{"post_id" => post_id, "type" => type}) do
    %{
      user_id: conn.assigns[:current_user].id,
      post_id: post_id,
      type: type
    }
    |> create_like()
    |> case do
      {:ok, _like} ->
        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Ocorreu um erro inesperado")
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end
  end

  def update(conn, %{"post_id" => post_id}) do
    case like_to_update = get_like(conn.assigns[:current_user].id, post_id) do
      %Like{} ->
        toggle_like_type(like_to_update)

        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      _ ->
        conn
        |> put_flash(:error, "Ocorreu um erro inesperado")
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end

  end
end
