defmodule ElixirBlogWeb.LikeController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Like

  def create(conn, %{"post_id" => post_id} = params) do
    %{id: user_id} = conn.assigns[:current_user]

    if Map.fetch(params, :comment_id) != :error do
      Map.pop(params, :post_id)
    end
    |> Map.put(:user_id, user_id)
    |> create_like()
    |> case do
      {:ok, _like} ->
        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      {:error, _changeset} ->
        conn
        |> put_status(500)
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
        |> put_status(500)
        |> put_flash(:error, "Ocorreu um erro inesperado")
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end
  end

  def delete(conn, %{"post_id" => post_id}) do
    case like_to_delete = get_like(conn.assigns[:current_user].id, post_id) do
      %Like{} ->
        delete_like(like_to_delete)

        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))

      _ ->
        conn
        |> put_status(500)
        |> put_flash(:error, "Ocorreu um erro inesperado")
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end
  end
end
