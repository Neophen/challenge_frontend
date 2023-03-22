defmodule FrontendChallenge.Repo do
  use Ecto.Repo,
    otp_app: :frontend_challenge,
    adapter: Ecto.Adapters.Postgres
end
