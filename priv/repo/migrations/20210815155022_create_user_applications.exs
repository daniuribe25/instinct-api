defmodule InstinctApi.Repo.Migrations.CreateUserApplications do
  use Ecto.Migration

  def change do
    create table(:user_applications) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :post_id, references(:posts, on_delete: :nothing), null: false
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:user_applications, [:user_id])
    create index(:user_applications, [:post_id])
  end
end
