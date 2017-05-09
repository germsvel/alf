defmodule Alf.CLI do
  alias Alf.{TodoList, Formatter}
  @list_name :"To do"

  @switches [print: :boolean, add: :string, clear: :boolean, complete: :string, done: :string, help: :boolean]
  @aliases [c: :complete, d: :done, a: :add, h: :help]

  def main(args \\ []) do
    args
    |> parse_args()
    |> response()

    save()
  end

  defp parse_args([]), do: [print: true]
  defp parse_args(args) do
    {opts, _argv, _errors} =
      args
      |> OptionParser.parse(aliases: @aliases, switches: @switches)

    opts
  end

  defp response([done: item]), do: response([complete: item])
  defp response([complete: item]) do
    TodoList.complete(@list_name, String.to_integer(item))

    print()
  end

  defp response([add: item]) do
    TodoList.add(@list_name, item)

    print()
  end

  defp response([clear: _]) do
    TodoList.clear_list(@list_name)

    print()
  end

  defp response([print: _]) do
    print()
  end

  defp response([]), do: response([help: true])
  defp response([help: _]) do
    IO.puts """

    alf - your todo list manager
    ======================================================

    Usage: alf [arguments]

    Arguments:
      --print                 # Print the current list
      --add <item>            # Add item to list
      --complete <itemNumber> # Remove item from list
      --done  <itemNumber>    # Same as completing an item
      --clear                 # Clear all items from list

    ======================================================
    """
  end

  defp save do
    TodoList.save(@list_name)
  end

  defp print do
    TodoList.all(@list_name)
    |> Formatter.list_to_text(@list_name)
    |> IO.puts()
  end
end
