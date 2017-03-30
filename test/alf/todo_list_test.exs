defmodule Alf.TodoListTest do
  use ExUnit.Case, async: true
  alias Alf.TodoList

  setup do
    on_exit(&TodoList.clear_list/0)
    {:ok, :ok}
  end

  describe "save/0" do
    test "stores list in file system" do
      TodoList.add("pick up eggs")
      TodoList.add("return video")

      TodoList.save()

      {:ok, text} = File.read("saved_todo_list")
      File.rm("saved_todo_list")

      assert text == """
      To do
      ======
      [1] pick up eggs
      [2] return video
      """
    end
  end

  describe "all/0" do
    test "returns list of all items in order they were added" do
      TodoList.add("pick up eggs")
      TodoList.add("return video")

      [h, t] = TodoList.all

      assert h == "pick up eggs"
      assert t == "return video"
    end
  end

  describe "add/1" do
    test "adds an item to the list" do
      TodoList.add("meet with clients")

      item = TodoList.last

      assert item == "meet with clients"
    end
  end

  describe "last/0" do
    test "returns the last item added to the list" do
      TodoList.add("meet with clients")

      item = TodoList.last

      assert item == "meet with clients"
    end
  end

  describe "complete/1" do
    test "removes item from list based on item position" do
      TodoList.add("write docs")
      TodoList.add("finish homework")

      TodoList.complete(2)

      [last] = TodoList.all
      assert last == "write docs"
    end

    test "removes item from list based on name" do
      TodoList.add("write docs")
      TodoList.add("finish homework")

      TodoList.complete("write docs")

      [last] = TodoList.all
      assert last == "finish homework"
    end

    test "keeps order of elements in list correctly after additions and completions" do
      TodoList.add("write docs")
      TodoList.add("finish homework")
      TodoList.complete(2)
      TodoList.add("write program")

      TodoList.complete("write program")

      [last] = TodoList.all
      assert last == "write docs"
    end
  end
end
