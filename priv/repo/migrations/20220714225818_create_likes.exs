defmodule ElixirBlog.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :likes
      remove :dislikes
    end

    create table(:likes, primary_key: false) do
      add :type, :string, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :post_id, references(:posts, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:likes, [:user_id])
    create index(:likes, [:post_id])
    create unique_index(:likes, [:user_id, :post_id])
  end
end
