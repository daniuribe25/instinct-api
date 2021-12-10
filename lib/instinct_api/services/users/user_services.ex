defmodule InstinctApi.Services.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias InstinctApi.Repo

  alias InstinctApi.Models.Users.User
  alias InstinctApi.Services.Helpers.{Queries, OrderBy, Pagination}

  @spec data :: Dataloader.Ecto.t()
  def data(), do: Dataloader.Ecto.new(InstinctApi.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def list do
    Repo.all(User)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from p in User, as: :users, where: p.active == true
    query = Queries.filter_search(:users, filter, query, [], [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(User, id)

  def get_by_email(email), do: Repo.get_by(User, email: email)

  def get_by_phone(phone), do: Repo.get_by(User, phone: phone)

  def create(attrs \\ %{}) do
    %User{}
    |> Ecto.Changeset.change(attrs)
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete(%User{} = user) do
    Repo.delete(user)
  end

  def change(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
