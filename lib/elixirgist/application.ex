defmodule Elixirgist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirgistWeb.Telemetry,
      Elixirgist.Repo,
      {DNSCluster, query: Application.get_env(:elixirgist, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Elixirgist.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Elixirgist.Finch},
      # Start a worker by calling: Elixirgist.Worker.start_link(arg)
      # {Elixirgist.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirgistWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elixirgist.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirgistWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
