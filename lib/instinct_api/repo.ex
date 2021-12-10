defmodule InstinctApi.Repo do
  use Ecto.Repo,
    otp_app: :instinct_api,
    adapter: Ecto.Adapters.Postgres
end
