defmodule ElixirBlog.Repo.Migrations.UsernameCollumUnnullable do
  use Ecto.Migration

  def change do
    execute("ALTER TABLE users ALTER COLUMN username DROP NOT NULL;")
    execute("ALTER TABLE users ALTER COLUMN username SET NOT NULL;")
    
  end
end
