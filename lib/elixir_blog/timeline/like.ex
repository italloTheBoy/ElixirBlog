defmodule ElixirBlog.Timeline.Like do
  use Ecto.Schema

  import Ecto.Changeset

  alias ElixirBlog.Accounts.User
  alias ElixirBlog.Timeline.Post

  @primary_key false

  schema "likes" do

    field :type, Ecto.Enum, values: [like: "like", dislike: "dislike"]

    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = like, attrs \\ %{}) do
    like
    |> cast(attrs, [:type, :user_id, :post_id])
    |> validate_associations()
    |> validate_type()
  end

  defp validate_type(changeset) do
    changeset
    |> validate_required([:type], message: "Reação requerida")
    |> validate_inclusion(:type, [:like, :dislike], message: "Reação invalida")
  end

  defp validate_associations(changeset) do
    changeset
    |> validate_user()
    |> validate_post()
    |> unsafe_validate_unique([:user_id, :post_id], ElixirBlog.Repo, message: "Reação ja existe", error_key: :like)
    |> unique_constraint([:user_id, :post_id], message: "Reação ja existe", error_key: :like)
  end

  defp validate_user(changeset) do
    changeset
    |> validate_required([:user_id], message:  "Login necessário")
    |> assoc_constraint(:user, message: "Login inválido")
  end

  defp validate_post(changeset) do
    changeset
    |> validate_required([:post_id], message:  "Post necessário")
    |> assoc_constraint(:post, message: "Post inválido")
  end
end
