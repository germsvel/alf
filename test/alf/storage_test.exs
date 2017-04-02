defmodule Alf.StorageTest do
  use ExUnit.Case, async: true
  alias Alf.Storage

  setup do
    on_exit(&Storage.clear_records/0)
    {:ok, :ok}
  end

  describe "store/2" do
    test "stores text to given filename" do
      Storage.store("hello world", "hello_world_file")

      text = Storage.get("hello_world_file")

      assert text == "hello world"
    end
  end

  describe "clear_records/0" do
    test "removes all saved records from file system" do
      Storage.store("hello world", "hello_world_file")

      Storage.clear_records

      refute File.exists?("lists")
    end
  end
end
