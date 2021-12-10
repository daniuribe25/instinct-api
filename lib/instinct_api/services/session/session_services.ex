defmodule InstinctApi.Services.Sessions do
  @moduledoc """
  The Users context.
  """
  import Ecto.Query, warn: false
  alias InstinctApi.Repo

  alias InstinctApi.Models.Users.User
  alias InstinctApi.Models.Companies.Company

  def authenticate(credentials) do
    with user <- Repo.get_by(User, email: credentials.email),
         {:ok, _} <- checkpw(user, credentials.password),
         {:ok, jwt_token, _} <- generate_token(user, :user) do
      {:ok, %{token: jwt_token, user: user}}
    else
      _ -> {:error}
    end
  end

  def authenticateCompany(credentials) do
    with company <- Repo.get_by(Company, email: credentials.email),
         {:ok, _} <- checkpw(company, credentials.password),
         {:ok, jwt_token, _} <- generate_token(company, :company) do
      {:ok, %{token: jwt_token, company: company}}
    else
      _ -> {:error}
    end
  end

  defp checkpw(user, password), do: Bcrypt.check_pass(user, password)

  defp generate_token(user, type), do: InstinctApi.Middlewares.Guardian.encode_and_sign(user, %{ type: type, role: user.role })
end
