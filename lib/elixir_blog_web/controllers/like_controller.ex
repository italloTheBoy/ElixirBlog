defmodule ElixirBlogWeb.LikeController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  def create(conn, %{"post_id" => post_id, "type" => like_type}) do
    conn.assigns[:current_user]
    |> create_like(%{post_id: post_id, type: like_type})

    conn
    |> put_flash(:info, "Post curtido.")
    |> redirect(to: Routes.post_path(conn, :show, post_id))
  end
end
