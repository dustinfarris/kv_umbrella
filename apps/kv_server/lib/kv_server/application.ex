defmodule KVServer.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # port = System.get_env("PORT") || raise "missing $PORT environment variable"

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: KVServer.Worker.start_link(arg1, arg2, arg3)
      # worker(KVServer.Worker, [arg1, arg2, arg3]),
      supervisor(Task.Supervisor, [[name: KVServer.TaskSupervisor]]),
      # worker(Task, [KVServer, :accept, [String.to_integer(port)]])
      worker(Task, [KVServer, :accept, [4040]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KVServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
