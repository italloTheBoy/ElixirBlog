defmodule ElixirBlogWeb.PostController do
  use ElixirBlogWeb, :controller

  import ElixirBlog.Timeline

  alias ElixirBlog.Timeline.{Post, Comment}

  def show(conn, %{"id" => post_id}) do
    user = conn.assigns.current_user

    post = get_post(post_id)

    comments = list_post_comments(post_id)

    like_type = get_like_type(user.id, post_id)

    changeset = Comment.changeset(%Comment{})

    render(conn, "show.html",
      post: post,
      comments: comments,
      like_type: like_type,
      changeset: changeset
    )
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
        |> put_flash(:info, "Post criado")
        |> redirect(to: Routes.perfil_path(conn, :index, user.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => post_id}) do
    case get_post(post_id) do
      %Post{user: user} = post ->
        delete_post(post)

        conn
        |> put_flash(:info, "Post deletada.")
        |> redirect(to: Routes.perfil_path(conn, :index, user.id))

      _ ->
        conn
        |> put_flash(:err, "Erro ou deletar o post")
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end
  end
end
