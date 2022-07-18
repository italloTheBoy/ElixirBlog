defmodule ElixirBlog.Repo.Migrations.TypeLenth do
  use Ecto.Migration

  def change do
    alter table(:likes) do
      remove :type

      add :type, :string, size: 7 ,null: false
    end
  end
end
