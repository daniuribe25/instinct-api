defmodule InstinctApi.Models.Users.UserApplication do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "user_applications" do
    belongs_to :user, InstinctApi.Models.Users.User
    belongs_to :post, InstinctApi.Models.Companies.Post
    field :active, :boolean, default: true

    timestamps()
  end

  def changeset(user_application, _) do
    user_application
  end
end
