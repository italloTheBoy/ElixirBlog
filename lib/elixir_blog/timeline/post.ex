defmodule ElixirBlog.Timeline.Post do
  use Ecto.Schema

  import Ecto.Changeset

  alias ElixirBlog.Accounts.{User}
  alias ElixirBlog.Timeline.{Like}

  schema "posts" do
    field :text, :string

    belongs_to :user, User

    has_many :likes, Like, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:text, :user_id])
    |> validate_text()
    |> validate_user()
  end

  defp validate_text(changeset) do
    changeset
    |> validate_required([:text], message: "Preencha o campo de texto.")
    |> validate_length(:text, max: 255, message: "Postagem muito longa.")
  end

  defp validate_user(changeset) do
    changeset
    |> validate_required([:user_id], message:  "Login necessário")
    |> assoc_constraint(:user, message: "Login inválido")
  end
end
