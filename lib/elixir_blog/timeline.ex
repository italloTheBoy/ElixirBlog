defmodule ElixirBlog.Timeline do
  @moduledoc """
  The Timeline context.
  """

  import Ecto.Query, warn: false

  alias ElixirBlog.Repo
  alias ElixirBlog.Accounts.User
  alias ElixirBlog.Timeline.Post
  alias ElixirBlog.Timeline.Like

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Returns a list of posts by specific user.

  ## Examples

      iex> list_posts(user_id)
      [%Post{}, ...]

  """
  def list_user_posts(user_id) do
    from(p in Post,
      where: p.user_id == ^user_id,
      order_by: p.inserted_at,
      preload: [:user]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Post
    |> preload(:user)
    |> Repo.get!(id)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%{text: text, user_id: user_id} \\ %{text: nil, user_id: nil}) do
    %Post{}
    |> change_post(%{text: text, user_id: user_id})
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  @doc """
  Returns the list of likes.

  ## Examples

      iex> list_likes()
      [%Like{}, ...]

  """
  def list_likes do
    Repo.all(Like)
  end

  @doc """
  Gets a single like.

  Raises `Ecto.NoResultsError` if the Like does not exist.

  ## Examples

      iex> get_like!(123, 231)
      %Like{}

      iex> get_like!(456, 122)
      ** (Ecto.NoResultsError)

  """
  def get_like!(user_id, post_id) do
    from(l in Like,
      where: l.user_id == ^user_id and l.post_id == ^post_id
    )
    |> Repo.one!
  end

  @doc """
  Gets a single like.

  ## Examples

      iex> get_like!(123, 231)
      %Like{}

      iex> get_like!(456, 122)
      ** (Ecto.NoResultsError)

  """
  def get_like(user_id, post_id) do
    from(l in Like,
      where: l.user_id == ^user_id and l.post_id == ^post_id
    )
    |> Repo.one
  end

  @doc """
  Returns the like type

  If the post has not been liked returns :unlike

  ## Examples

      iex> get_like_type(8, 2)
      :like

      iex> get_like_type(5, 7)
      :unlike

      iex> get_like_type(9, 4)
      :dislike
  """
  def get_like_type(user_id, post_id) do
    get_like(user_id, post_id)
    |>  IO.inspect()
    |> case do
      %Like{type: type} -> type

      _ -> :unlike
    end
  end

  @doc """
  Creates a like.

  ## Examples

      iex> create_like(%{user: value, post_id: value, type: value})
      {:ok, %Like{}}

      iex> create_like(%{user: bad_value, post_id: bad_value, type: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_like(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a like.

  ## Examples

      iex> update_like(like, %{field: new_value})
      {:ok, %Like{}}

      iex> update_like(like, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def toggle_like_type(%Like{type: original_type} = like) do
    new_type =
      case original_type do
        :like -> :dislike
        :dislike -> :like
      end

    from(l in Like,
      where: l.user_id == ^like.user_id and l.post_id == ^like.post_id,
      update: [set: [type: ^new_type]]
    )
    |> Repo.update_all([])
  end

  @doc """
  Deletes a like.

  ## Examples

      iex> delete_like(like)
      {:ok, %Like{}}

      iex> delete_like(like)
      {:error, %Ecto.Changeset{}}

  """
  def delete_like(%Like{} = like) do
    Repo.delete(like)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking like changes.

  ## Examples

      iex> change_like(like)
      %Ecto.Changeset{data: %Like{}}

  """
  def change_like(%Like{} = like, attrs \\ %{}) do
    Like.changeset(like, attrs)
  end
end
