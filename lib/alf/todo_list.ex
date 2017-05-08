defmodule Alf.TodoList do
  alias Alf.{Formatter, Storage}

  def start_link(name) do
    result = Agent.start_link(fn -> [] end, name: name)
    load_data(name)
    result
  end

  def load_data(name) do
    Atom.to_string(name)
    |> Storage.get()
    |> Formatter.text_to_list()
    |> Enum.each(fn item ->
      add(name, item)
    end)
  end

  def save(name) do
    title = Atom.to_string(name)

    all(name)
    |> Formatter.list_to_text(title)
    |> Storage.store(title)
  end

  def all(name) do
    Agent.get(name, fn items ->
      Enum.reverse(items)
    end)
  end

  def last(name) do
    Agent.get(name, fn [h|_t] -> h end)
  end

  def add(name, desc) do
    Agent.update(name, fn items ->
      [desc | items]
    end)
  end

  def complete(name, position) when is_integer(position) do
    Agent.update(name, fn items ->
      total = length(items)

      List.delete_at(items, total - position)
    end)
  end

  def complete(name, desc) when is_binary(desc) do
    Agent.update(name, fn items ->
      List.delete(items, desc)
    end)
  end

  def clear_list(name) do
    Agent.update(name, fn _ -> [] end)
  end
end
