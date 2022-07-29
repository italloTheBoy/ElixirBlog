defmodule ElixirBlog.Repo.Migrations.AddCommentToLikeTableAndCheckConstranint do
  use Ecto.Migration

  def change do
    alter table(:likes) do
      add :comment_id, references(:comments, on_delete: :delete_all)
    end

    execute("ALTER TABLE likes ALTER COLUMN post_id DROP NOT NULL;")

    create constraint(
      :likes,
      :like_belongs_to_only_interaction,
      check: "(post_id IS NULL AND comment_id IS NOT NULL) OR (comment_id IS NULL AND post_id IS NOT NULL) "
    )
  end
end
