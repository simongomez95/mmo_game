defmodule FormavivaMmo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      FormavivaMmo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: FormavivaMmo.PubSub},
      # Start the Endpoint (http/https)
      FormavivaMmoWeb.Endpoint,
      # Start a worker by calling: FormavivaMmo.Worker.start_link(arg)
      # {FormavivaMmo.Worker, arg}
      {Registry, keys: :unique, name: FormavivaMmo.GameRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: FormavivaMmo.GameSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FormavivaMmo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FormavivaMmoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
