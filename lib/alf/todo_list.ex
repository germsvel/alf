defmodule Alf.TodoList do
  alias Alf.Formatter
  alias Alf.Storage

  @name __MODULE__

  def start_link do
    result = Agent.start_link(fn -> [] end, name: @name)
    load_data()
    result
  end

  def load_data do
    Storage.get("saved_todo_list")
    |> Formatter.text_to_list()
    |> Enum.each(&add/1)
  end

  def save do
    all()
    |> Formatter.list_to_text("To do")
    |> Storage.store("saved_todo_list")
  end

  def print do
    all()
    |> Formatter.list_to_text("To do")
    |> IO.puts()
  end

  def all do
    Agent.get(@name, fn items ->
      Enum.reverse(items)
    end)
  end

  def last do
    Agent.get(@name, fn [h|_t] ->
      h
    end)
  end

  def add(desc) do
    Agent.update(@name, fn items ->
      [desc | items]
    end)
  end

  def complete(position) when is_integer(position) do
    Agent.update(@name, fn items ->
      total = length(items)

      List.delete_at(items, total - position)
    end)
  end

  def complete(desc) when is_binary(desc) do
    Agent.update(@name, fn items ->
      List.delete(items, desc)
    end)
  end

  def clear_list do
    Agent.update(@name, fn _ ->
      []
    end)
  end
end
