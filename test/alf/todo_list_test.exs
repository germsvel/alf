defmodule Alf.TodoListTest do
  use ExUnit.Case, async: true
  alias Alf.TodoList

  setup do
    on_exit(&Alf.Storage.clear_records/0)
    :ok
  end

  describe "load_data/0" do
    test "loads data from file system when starting link", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "pick up eggs")
      TodoList.add(name, "return video")
      TodoList.save(name)
      TodoList.clear_list(name)

      TodoList.load_data(name)

      [item1, item2] = TodoList.all(name)

      assert item1 == "pick up eggs"
      assert item2 == "return video"
    end
  end

  describe "save/1" do
    test "stores list in file system", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "pick up eggs")
      TodoList.add(name, "return video")

      TodoList.save(name)

      text = Atom.to_string(name)
           |> Alf.Storage.get()
      Alf.Storage.clear_records

      assert text == """

      #{name}
      ======
      [1] pick up eggs
      [2] return video
      """
    end
  end

  describe "all/1" do
    test "returns list of all items in order they were added", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "pick up eggs")
      TodoList.add(name, "return video")

      [h, t] = TodoList.all(name)

      assert h == "pick up eggs"
      assert t == "return video"
    end
  end

  describe "add/2" do
    test "adds an item to the list", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)

      TodoList.add(name, "meet with clients")

      item = TodoList.last(name)
      assert item == "meet with clients"
    end
  end

  describe "last/1" do
    test "returns the last item added to the list", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "meet with clients")

      item = TodoList.last(name)

      assert item == "meet with clients"
    end
  end

  describe "complete/2" do
    test "removes item from list based on item position", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "write docs")
      TodoList.add(name, "finish homework")

      TodoList.complete(name, 2)

      [last] = TodoList.all(name)
      assert last == "write docs"
    end

    test "removes item from list based on name", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "write docs")
      TodoList.add(name, "finish homework")

      TodoList.complete(name, "write docs")

      [last] = TodoList.all(name)
      assert last == "finish homework"
    end

    test "keeps order of elements in list correctly after additions and completions", context do
      name = context[:test]
      {:ok, _} = TodoList.start_link(name)
      TodoList.add(name, "write docs")
      TodoList.add(name, "finish homework")
      TodoList.complete(name, 2)
      TodoList.add(name, "write program")

      TodoList.complete(name, "write program")

      [last] = TodoList.all(name)
      assert last == "write docs"
    end
  end
end
