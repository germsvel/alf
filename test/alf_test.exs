defmodule AlfTest do
  use ExUnit.Case
  doctest Alf

  test "starts the todo list process" do
    pid = Process.whereis(Alf.TodoList)

    assert Process.alive?(pid)
  end
end
