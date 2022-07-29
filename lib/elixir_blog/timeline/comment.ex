defmodule ElixirBlog.Timeline.Comment do
  use Ecto.Schema

  import Ecto.Changeset

  alias ElixirBlog.Accounts.{User}
  alias ElixirBlog.Timeline.{Post, Like}


  schema "comments" do
    field :text, :string

    belongs_to :user, User
    belongs_to :post, Post

    has_many :likes, Like, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:text, :user_id, :post_id])
    |> validate_text()
    |> validate_user()
    |> validate_post()
  end

  @doc false
  defp validate_text(changeset) do
    changeset
    |> validate_required([:text], message: "Preencha o campo de texto.")
    |> validate_length(:text, max: 255, message: "Postagem muito longa.")
  end

  @doc false
  defp validate_user(changeset) do
    changeset
    |> validate_required([:user_id], message:  "Login necessário")
    |> assoc_constraint(:user, message: "Login inválido")
  end

  @doc false
  defp validate_post(changeset) do
    changeset
    |> validate_required([:post_id], message:  "Post necessário")
    |> assoc_constraint(:user, message: "Post inválido")
  end
end
