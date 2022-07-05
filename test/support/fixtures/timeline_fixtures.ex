defmodule ElixirBlog.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirBlog.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        dislikes: 42,
        likes: 42,
        text: "some text"
      })
      |> ElixirBlog.Timeline.create_post()

    post
  end
end
