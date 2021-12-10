defmodule InstinctApiWeb.Graphql.Resolvers.UserApplication do
  alias InstinctApi.Services.UserApplications, as: UserApplicationServices

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{ size: 0, page: 0 }
    {:ok, UserApplicationServices.list_by_filter(filter, order_by, paginate)}
  end

  def create(%{post_id: post_id}, %{context: context}) do
    post_application = %{
      user_id: context.current_user.id,
      post_id: post_id
    }
    case UserApplicationServices.create(post_application) do
      {:ok, user_application} -> {:ok, user_application}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end
end
