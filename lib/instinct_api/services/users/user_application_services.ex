defmodule InstinctApi.Services.UserApplications do
  @moduledoc """
  The UserApplications context.
  """

  import Ecto.Query, warn: false
  alias InstinctApi.Repo

  alias InstinctApi.Models.Users.UserApplication
  alias InstinctApi.Services.Helpers.{Queries, OrderBy, Pagination}

  def list do
    Repo.all(User)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from ua in UserApplication, as: :user_application, where: ua.active == true
    query = Queries.filter_search(:user_application, filter, query, [], [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(UserApplication, id)

  def create(attrs \\ %{}) do
    %UserApplication{}
    |> Ecto.Changeset.change(attrs)
    |> UserApplication.changeset(attrs)
    |> Repo.insert()
  end

  def update(%UserApplication{} = user_application, attrs) do
    user_application
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%UserApplication{} = user_application) do
    Repo.delete(user_application)
  end

  def change(%UserApplication{} = user_application, attrs \\ %{}) do
    UserApplication.changeset(user_application, attrs)
  end
end
