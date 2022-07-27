defmodule ElixirBlogWeb.CommentController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.Comment

  def new(conn, _params) do
    changeset = Comment.changeset(%Comment{})

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
