defmodule InstinctApi.Repo.Migrations.CreateUserEducations do
  use Ecto.Migration

  def change do
    create table(:user_educations) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :title, :string, null: false
      add :institution, :string, null: false
      add :from, :utc_datetime, null: false
      add :to, :utc_datetime, null: false
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:user_educations, [:user_id])
  end
end
