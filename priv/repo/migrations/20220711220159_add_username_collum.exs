defmodule ElixirBlog.Repo.Migrations.AddUsernameCollum do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, size: 20
    end
  end
end
