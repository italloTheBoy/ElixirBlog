defmodule ElixirBlogWeb.PerfilController do
  use ElixirBlogWeb, :controller
  import ElixirBlog.Accounts
  import ElixirBlog.Timeline

  def index(conn, %{"user_id" => user_id}) do
    user = get_user!(user_id)
    posts = list_user_posts(user_id)

    render(conn, "index.html", user: user, posts: posts)
  end
end
