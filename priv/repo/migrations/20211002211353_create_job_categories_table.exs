defmodule InstinctApi.Repo.Migrations.CreateJobCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:job_categories) do
      add :name, :string, null: false
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    alter table(:user_resumes) do
      remove :job_type
      add :job_type, {:array, :string}

      remove :category
      add :category, {:array, :string}
    end

    alter table(:posts) do
      remove :job_type
      add :job_type, {:array, :string}
    end
  end
end
