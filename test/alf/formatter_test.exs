defmodule Alf.FormatterTest do
  use ExUnit.Case, async: true
  alias Alf.Formatter

  describe "list_to_text/2" do
    test "formats a list and title" do
      list = ["eggs", "bacon"]

      text = Formatter.list_to_text(list, "Breakfast items")

      assert text == """

      Breakfast items
      ======
      [1] eggs
      [2] bacon
      """
    end
  end

  describe "list_to_text/1" do
    test "formats a list" do
      list = ["eggs", "bacon"]

      text = Formatter.list_to_text(list)

      assert text == """
      [1] eggs
      [2] bacon
      """
    end
  end

  describe "text_to_list/1" do
    test "parses text into a list of items" do
      text = """
      [1] eggs
      [2] bacon
      """

      list = Formatter.text_to_list(text)

      assert list == ["eggs", "bacon"]
    end

    test "parses text with title into a list of items" do
      text = """
      Breakfast items
      ======
      [1] eggs
      [2] bacon
      """

      list = Formatter.text_to_list(text)

      assert list == ["eggs", "bacon"]
    end
  end
end
