defmodule ElixirBlog.Repo do
  use Ecto.Repo,
    otp_app: :elixir_blog,
    adapter: Ecto.Adapters.Postgres
end
