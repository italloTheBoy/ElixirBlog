defmodule ElixirBlog.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :dislikes, :integer, default: 0
    field :likes, :integer, default: 0
    field :text, :string

    belongs_to :user, ElixirBlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:text, :likes, :dislikes, :user_id])
    |> validate_required([:text], message: "Preencha o campo de texto.")
    |> assoc_constraint(:user, message: "Login inválido")
    |> validate_length(:text, max: 255, message: "Postagem muito longa.")
    |> validate_number(:likes, greater_than: -1, message: "número invalido de likes")
    |> validate_number(:dislikes, greater_than: -1, message: "número invalido de dislikes")
  end

  
end
