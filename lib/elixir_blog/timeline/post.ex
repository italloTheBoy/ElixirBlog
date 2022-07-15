defmodule ElixirBlog.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirBlog.Accounts.{User}
  alias ElixirBlog.Timeline.{Like}

  schema "posts" do
    field :text, :string

    has_many :likes, Like, on_delete: :delete_all

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:text, :likes, :dislikes, :user_id])
    |> validate_text()
    |> validate_user_id()
  end

  defp validate_text(changeset) do
    changeset
    |> validate_required([:text], message: "Preencha o campo de texto.")
    |> validate_length(:text, max: 255, message: "Postagem muito longa.")
  end

  defp validate_user_id(changeset) do
    changeset
    |> assoc_constraint(:user, message: "Login inválido")
  end
end
