defmodule Alf do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Alf.TodoList, [:"To do"]),
    ]

    opts = [strategy: :one_for_one, name: Alf.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
