defmodule InstinctApi.Middlewares.Guardian do
  use Guardian, otp_app: :instinct_api
  alias InstinctApi.Services.Users
  alias InstinctApi.Services.Companies

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id, "type" => type}) do
    case type do
      "user" -> get_user(id)
      "company" -> get_company(id)
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  defp get_user(id) do
    case Users.get(id) do
      %InstinctApi.Models.Users.User{} = user -> {:ok, user}
      _ -> {:error, :resource_not_found}
    end
  end

  defp get_company(id) do
    case Companies.get(id) do
      %InstinctApi.Models.Companies.Company{} = user -> {:ok, user}
      _ -> {:error, :resource_not_found}
    end
  end
end
