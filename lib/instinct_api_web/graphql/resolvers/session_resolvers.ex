defmodule InstinctApiWeb.Graphql.Resolvers.Session do
  alias InstinctApi.Services.Sessions, as: SessionsServices
  alias InstinctApi.Services.Users, as: UsersServices
  alias InstinctApi.Services.Companies, as: CompanyServices

  def authenticate(%{credentials: credentials}, _info) do
    case SessionsServices.authenticate(credentials) do
      {:ok, user_token} -> {:ok, user_token}
      {:error} ->
        case SessionsServices.authenticateCompany(credentials) do
          {:ok, user_token} -> {:ok, user_token}
          {:error} -> {:error, "invalid credentials"}
        end
    end
  end

  def get_own(_params, %{ context: context }) do
    case Map.has_key?(context, :current_user) do
      true -> case context.current_user.role do
        "employer" -> {:ok, %{ :company => CompanyServices.get(context.current_user.id) }}
        "seeker" -> {:ok, %{ :user => UsersServices.get(context.current_user.id) }}
        _ -> {:error, "Unknown"}
      end
      _ -> {:error, "Unknown"}
    end
  end
end
