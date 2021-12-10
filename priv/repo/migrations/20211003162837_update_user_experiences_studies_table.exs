defmodule InstinctApi.Repo.Migrations.UpdateUserExperiencesStudiesTable do
  use Ecto.Migration

  def change do
    alter table(:user_work_experiences) do
      remove :from
      add :from, :date

      remove :to
      add :to, :date
    end

    alter table(:user_educations) do
      remove :from
      add :from, :date

      remove :to
      add :to, :date
    end
  end
end
