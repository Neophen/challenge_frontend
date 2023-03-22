import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :frontend_challenge, FrontendChallenge.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "frontend_challenge_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :frontend_challenge, FrontendChallengeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "7R7Noz16c2o9R7Nuv3h8UAoU4xqi2GbUzIiG5ayKnk4o7dzg803vW8E1GSKWGTgD",
  server: false

# In test we don't send emails.
config :frontend_challenge, FrontendChallenge.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
