defmodule PolygonApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PolygonApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PolygonApi.PubSub},
      # Start Finch
      {Finch, name: PolygonApi.Finch},
      # Start the Endpoint (http/https)
      PolygonApiWeb.Endpoint
      # Start a worker by calling: PolygonApi.Worker.start_link(arg)
      # {PolygonApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PolygonApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PolygonApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
