defmodule Alf.TodoList do
  @name __MODULE__

  alias Alf.Formatter

  def start_link do
    Agent.start_link(fn -> [] end, name: @name)
  end

  def save do
    list_to_text()
    |> write_to_file()
  end

  def print do
    IO.puts list_to_text()
  end

  defp list_to_text do
    all() |> Formatter.list_to_text("To do")
  end

  defp write_to_file(text) do
    {:ok, file} = File.open("saved_todo_list", [:write])

    IO.write(file, text)
    File.close(file)
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
