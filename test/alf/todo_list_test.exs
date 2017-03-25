defmodule Alf.TodoListTest do
  use ExUnit.Case, async: true
  alias Alf.TodoList

  setup do
    {:ok, pid} = TodoList.start_link
    {:ok, todo_list: pid}
  end

  describe "start_link/0" do
    test "Stores a list of items" do
      list = TodoList.all

      assert list == []
    end
  end

  describe "add/1" do
    test "adds item to list" do
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

      [last] = TodoList.last

      assert last == "write docs"
    end

    test "removes item from list based on name" do
      TodoList.add("write docs")
      TodoList.add("finish homework")

      TodoList.complete("write docs")

      assert TodoList.last == "finish homework"
    end
  end
end
