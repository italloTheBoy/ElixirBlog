defmodule ElixirBlog.Repo.Migrations.AlterPostNullableTables do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :likes
      remove :dislikes
      remove :user_id

      add :likes, :integer, default: 0, null: false
      add :dislikes, :integer, default: 0, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
    end
  end
end
