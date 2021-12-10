defmodule InstinctApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :fullname, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :phone, :string
      add :role, :string, default: "seeker", null: false
      add :accept_terms, :boolean, default: false, null: false
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:users, [:email], name: "users_unique_email_index")
    create unique_index(:users, [:phone], name: "users_unique_phone_index")
  end
end
