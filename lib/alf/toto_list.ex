defmodule Alf.TodoList do
  alias Alf.Todo

  defstruct items: %{}, next_position: 1

  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> %Alf.TodoList{} end, name: @name)
  end

  def all do
    Agent.get(@name, fn list ->
      Map.values(list.items)
    end)
  end

  def last do
    Agent.get(@name, fn list ->
      [desc|_] = Map.values(list.items)
      desc
    end)
  end

  def add(desc) do
    Agent.update(@name, fn list ->
      items = Map.put(list.items, list.next_position, desc)
      new_next_position = list.next_position + 1
      %{list | items: items, next_position: new_next_position}
    end)
  end

  def complete(position) when is_integer(position) do
    Agent.get_and_update(@name, fn list ->
      value = Map.get(list, position)
      new_list = Map.drop(list, [position])
      {value, new_list}
    end)
  end
end
