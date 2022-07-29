# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirBlog.Repo.insert!(%ElixirBlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ElixirBlog.Timeline.Like
alias ElixirBlog.Repo

attrs = %{
  type: "like",
  user_id: 3,
  post_id: 73,
  # comment_id: 1,
}

%Like{}
|> Like.changeset(attrs)
|> Repo.insert()
|> IO.inspect()
