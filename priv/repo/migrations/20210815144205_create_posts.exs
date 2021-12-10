defmodule InstinctApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :company_id, references(:companies, on_delete: :delete_all), null: false
      add :title, :string, null: false
      add :logo, :string
      add :location, :string
      add :salary_base, :integer, default: 0
      add :salary_up_to, :integer, default: 0
      add :salary_frequency, :string
      add :job_type, :string, default: "fulltime"
      add :labels, {:array, :string}
      add :description, :text
      add :vacants, :integer, default: 1
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:posts, [:company_id])
  end
end
