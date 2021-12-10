defmodule InstinctApi.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :phone, :string
      add :description, :text
      add :logo, :string
      add :website, :string
      add :role, :string, default: "employer", null: false
      add :post_credits, :integer, default: 0, null: false
      add :accept_terms, :boolean, default: false, null: false
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:companies, [:name], name: "companies_unique_name_index")
    create unique_index(:companies, [:email], name: "companies_unique_email_index")
    create unique_index(:companies, [:phone], name: "companies_unique_phone_index")
  end
end
