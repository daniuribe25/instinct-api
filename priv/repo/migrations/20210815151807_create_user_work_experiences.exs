defmodule InstinctApi.Repo.Migrations.CreateUserWorkExperiences do
  use Ecto.Migration

  def change do
    create table(:user_work_experiences) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :position, :string, null: false
      add :company, :string, null: false
      add :from, :utc_datetime, null: false
      add :to, :utc_datetime, null: false
      add :description, :text
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:user_work_experiences, [:user_id])
  end
end
