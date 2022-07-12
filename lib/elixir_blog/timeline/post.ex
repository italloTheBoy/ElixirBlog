defmodule ElixirBlog.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :text, :string
    field :likes, :integer, default: 0
    field :dislikes, :integer, default: 0

    belongs_to :user, ElixirBlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:text, :likes, :dislikes, :user_id])
    |> validate_text()
    |> validate_likes()
    |> validate_dislikes()
    |> validate_user_id()
  end

  defp validate_text(changeset) do
    changeset
    |> validate_required([:text], message: "Preencha o campo de texto.")
    |> validate_length(:text, max: 255, message: "Postagem muito longa.")
  end

  defp validate_likes(changeset) do
    changeset
    |> validate_number(:likes, greater_than: -1, message: "número invalido de likes")

  end

  defp validate_dislikes(changeset) do
    changeset
    |> validate_number(:dislikes, greater_than: -1, message: "número invalido de dislikes")
  end

  defp validate_user_id(changeset) do
    changeset
    |> assoc_constraint(:user, message: "Login inválido")
  end
end
