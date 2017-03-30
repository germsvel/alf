defmodule Alf.StorageTest do
  use ExUnit.Case, async: true
  alias Alf.Storage

  describe "store/2" do
    test "stores text in file named according to given name" do
      Storage.store("hello world", "hello_world_file")

      {:ok, text} = File.read("hello_world_file")
      File.rm("hello_world_file")

      assert text == "hello world"
    end
  end
end
