defmodule ElixirBlog.Timeline.Like do
  use Ecto.Schema

  import Ecto.Changeset

  alias ElixirBlog.Accounts.User
  alias ElixirBlog.Timeline.{Post, Comment}

  @permitted_columns [:type, :user_id, :post_id, :comment_id]
  @primary_key false

  schema "likes" do
    field :type, Ecto.Enum, values: [like: "like", dislike: "dislike"]

    belongs_to :user, User
    belongs_to :post, Post
    belongs_to :comment, Comment

    timestamps()
  end

  @doc false
  def changeset(like, attrs \\ %{}) do
    like
    |> cast(attrs, @permitted_columns)
    |> validate_associations()
    |> validate_type()
  end

  @doc false
  defp validate_type(changeset) do
    changeset
    |> validate_required([:type], message: "Reação requerida")
    |> validate_inclusion(:type, [:like, :dislike], message: "Reação invalida")
  end

  @doc false
  defp validate_associations(changeset) do
    changeset
    |> check_constraint(:like,
      name: :like_belongs_to_only_interaction,
      message: "Reação inválida"
    )
    |> validate_user()
    |> validate_post()
    |> validate_comment()
  end

  @doc false
  defp validate_user(changeset) do
    changeset
    |> validate_required([:user_id], message: "Login necessário")
    |> assoc_constraint(:user, message: "Login inválido")
  end

  @doc false
  defp validate_post(changeset) do
    changeset
    |> assoc_constraint(:post, message: "Post inválido")
    |> unsafe_validate_unique([:user_id, :post_id], ElixirBlog.Repo,
      message: "Reação ja existe",
      error_key: :like
    )
    |> unique_constraint([:user_id, :post_id], message: "Reação ja existe", error_key: :like)
  end

  @doc false
  defp validate_comment(changeset) do
    changeset
    |> assoc_constraint(:comment, message: "Comentario inválido")
    |> unsafe_validate_unique([:user_id, :comment_id], ElixirBlog.Repo,
      message: "Reação ja existe",
      error_key: :like
    )
    |> unique_constraint([:user_id, :comment_id], message: "Reação ja existe", error_key: :like)
  end
end
