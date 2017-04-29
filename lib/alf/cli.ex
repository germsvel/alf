defmodule Alf.CLI do
  alias Alf.{TodoList, Formatter}

  @switches [print: :boolean, add: :string, clear: :boolean, complete: :string, done: :string]
  @aliases [c: :complete, d: :done, a: :add]

  def main(args \\ []) do
    args
    |> parse_args()
    |> response()

    save()
    print()
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
    item
    |> String.to_integer()
    |> TodoList.complete()
  end

  defp response([add: item]) do
    TodoList.add item
  end

  defp response([clear: _]) do
    TodoList.clear_list()
  end

  defp response([print: _]) do
  end

  defp save do
    TodoList.save()
  end

  defp print do
    TodoList.all()
    |> Formatter.list_to_text("To do")
    |> IO.puts()
  end
end
