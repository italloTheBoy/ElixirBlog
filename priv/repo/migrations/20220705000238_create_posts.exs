defmodule ElixirBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text,     :string,  null: false
      add :likes,    :integer, default: 0
      add :dislikes, :integer, default: 0

      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:user_id])
  end

end
