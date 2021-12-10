# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :instinct_api,
  ecto_repos: [InstinctApi.Repo]

# Configures the endpoint
config :instinct_api, InstinctApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "z5NRU5u4UzV+yod24ay3bBraZe0oniQAhdctI8Qvt5ibWBswAEL2YDEOVhIKTjim",
  render_errors: [view: InstinctApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: InstinctApi.PubSub,
  live_view: [signing_salt: "F1Q0J8xI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config details
config :instinct_api, InstinctApi.Middlewares.Guardian,
  issuer: "instinct_api",
  secret_key: "g0S9+X2sETO26JsS/CZ6okYeeI0BqQd46zw5FlDWyQzMuYbRrHzWzX9wKGGiiBah"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
