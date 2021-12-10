defmodule InstinctApiWeb.Graphql.Resolvers.Users do
  alias InstinctApi.Services.Users, as: UsersServices

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{ size: 0, page: 0 }
    {:ok, UsersServices.list_by_filter(filter, order_by, paginate)}
  end

  def by_id(%{id: user_id}, _info) do
    {:ok, UsersServices.get(user_id)}
  end

  def create(%{user: attrs}, _info) do
    case UsersServices.create(attrs) do
      {:ok, user} -> {:ok, user}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end
end
