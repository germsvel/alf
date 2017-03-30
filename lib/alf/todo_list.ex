defmodule Alf.TodoList do
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> [] end, name: @name)
  end

  def print do
    IO.puts "\nTo do"
    IO.puts "========"

    all()
    |> Enum.with_index()
    |> Enum.each(&print_line/1)

    IO.puts "\n"
  end

  defp print_line({desc, index}) do
    IO.puts "[#{index + 1}] #{desc}"
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
