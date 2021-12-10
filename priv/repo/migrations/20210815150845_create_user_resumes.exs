defmodule InstinctApi.Repo.Migrations.CreateUserResumes do
  use Ecto.Migration

  def change do
    create table(:user_resumes) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :resume_url, :string
      add :job_type, :string, default: "fulltime", null: false
      add :category, :string, default: "others", null: false
      add :summary, :text
      add :city, :string
      add :country, :string
      add :photo_url, :string
      add :desired_salary, :integer, default: 0
      add :desired_job_title, :string
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:user_resumes, [:user_id])
  end
end
