defmodule ElixirBlog.TimelineTest do
  use ElixirBlog.DataCase

  alias ElixirBlog.Timeline

  describe "posts" do
    alias ElixirBlog.Timeline.Post

    import ElixirBlog.TimelineFixtures

    @invalid_attrs %{dislikes: nil, likes: nil, text: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Timeline.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Timeline.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{dislikes: 42, likes: 42, text: "some text"}

      assert {:ok, %Post{} = post} = Timeline.create_post(valid_attrs)
      assert post.dislikes == 42
      assert post.likes == 42
      assert post.text == "some text"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{dislikes: 43, likes: 43, text: "some updated text"}

      assert {:ok, %Post{} = post} = Timeline.update_post(post, update_attrs)
      assert post.dislikes == 43
      assert post.likes == 43
      assert post.text == "some updated text"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(post, @invalid_attrs)
      assert post == Timeline.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Timeline.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Timeline.change_post(post)
    end
  end

  describe "likes" do
    alias ElixirBlog.Timeline.Like

    import ElixirBlog.TimelineFixtures

    @invalid_attrs %{type: nil}

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Timeline.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Timeline.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      valid_attrs = %{type: "some type"}

      assert {:ok, %Like{} = like} = Timeline.create_like(valid_attrs)
      assert like.type == "some type"
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      update_attrs = %{type: "some updated type"}

      assert {:ok, %Like{} = like} = Timeline.update_like(like, update_attrs)
      assert like.type == "some updated type"
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_like(like, @invalid_attrs)
      assert like == Timeline.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Timeline.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Timeline.change_like(like)
    end
  end

  describe "comments" do
    alias ElixirBlog.Timeline.Comment

    import ElixirBlog.TimelineFixtures

    @invalid_attrs %{text: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Timeline.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Timeline.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Comment{} = comment} = Timeline.create_comment(valid_attrs)
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Comment{} = comment} = Timeline.update_comment(comment, update_attrs)
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_comment(comment, @invalid_attrs)
      assert comment == Timeline.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Timeline.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Timeline.change_comment(comment)
    end
  end
end
