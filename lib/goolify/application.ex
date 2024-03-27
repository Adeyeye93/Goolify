defmodule Goolify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GoolifyWeb.Telemetry,
      Goolify.Repo,
      {DNSCluster, query: Application.get_env(:goolify, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Goolify.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Goolify.Finch},
      # Start a worker by calling: Goolify.Worker.start_link(arg)
      # {Goolify.Worker, arg},
      # Start to serve requests, typically the last entry
      GoolifyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Goolify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GoolifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
