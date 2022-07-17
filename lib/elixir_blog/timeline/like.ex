defmodule ElixirBlog.Timeline.Like do
  use Ecto.Schema

  import Ecto.Changeset

  alias ElixirBlog.Accounts.User
  alias ElixirBlog.Timeline.Post

  schema "likes" do
    field :type, Ecto.Enum, values: [like: "like", dislike: "dislike"]

    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:type])
    |> validate_type()
    |> validate_associations()
  end

  def validate_type(changeset) do
    changeset
    |> validate_required([:type], message: "Reação invalida")
    |> validate_inclusion(:type, [:like, :dislike], message: "Reação invalida")
  end

  def validate_associations(changeset) do
    changeset
    |> cast_assoc(:user, required: true)
    |> cast_assoc(:post, required: true)
    |> assoc_constraint(:user, message: "Usuário inválido")
    |> assoc_constraint(:post, message: "Post inválido")
    |> unique_constraint([:user, :post], message: "Reação ja existe")
  end

end
