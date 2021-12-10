defmodule InstinctApiWeb.Graphql.Resolvers.Resumes do
  alias InstinctApi.Services.UserResumes, as: ResumeServices

  def list(_parent, %{ filter: filter }, _info), do: {:ok, ResumeServices.list_by_filter(filter)}
  def list(_parent, %{}, _info), do: {:ok, ResumeServices.list_by_filter(%{})}

  def by_id(%{id: id}, _info) do
    {:ok, ResumeServices.get(id)}
  end

  def create(%{resume: attrs}, %{context: context}) do
    new_attrs = Map.put(attrs, :user_id, context.current_user.id)
    case ResumeServices.create(new_attrs) do
      {:ok, resume} -> {:ok, resume}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end
end
