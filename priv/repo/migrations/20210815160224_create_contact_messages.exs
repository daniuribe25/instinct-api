defmodule InstinctApi.Repo.Migrations.CreateContactMessages do
  use Ecto.Migration

  def change do
    create table(:contact_messages) do
      add :fullname, :string, default: "anonymus", null: false
      add :email, :string, null: false
      add :phone, :string
      add :message, :text, null: false

      timestamps()
    end

  end
end
