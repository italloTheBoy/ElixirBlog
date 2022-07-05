defmodule ElixirBlog.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :dislikes, :integer, default: 0
    field :likes,    :integer, default: 0
    field :text,     :string

    belongs_to :user, ElixirBlog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text, :likes, :dislikes])
    |> validate_required([:text, :likes, :dislikes])
  end
end
