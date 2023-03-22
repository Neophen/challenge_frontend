defmodule FrontendChallenge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FrontendChallengeWeb.Telemetry,
      # Start the Ecto repository
      FrontendChallenge.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: FrontendChallenge.PubSub},
      # Start Finch
      {Finch, name: FrontendChallenge.Finch},
      # Start the Endpoint (http/https)
      FrontendChallengeWeb.Endpoint
      # Start a worker by calling: FrontendChallenge.Worker.start_link(arg)
      # {FrontendChallenge.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FrontendChallenge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FrontendChallengeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
