defmodule Alf.Formatter do
  def list_to_text(list), do: list_to_text(list, "")
  def list_to_text(list, title) do
    list
    |> Enum.with_index()
    |> append_items_to_text(format_title(title))
  end

  defp append_items_to_text([], text), do: text
  defp append_items_to_text([h|t], text) do
    new_text = text <> format_line(h) <> "\n"
    append_items_to_text(t, new_text)
  end

  defp format_line({desc, index}), do: "[#{index + 1}] #{desc}"

  defp format_title(""), do: ""
  defp format_title(title) do
    """
    #{title}
    ======
    """
  end


  def text_to_list(""), do: []
  def text_to_list(text) do
    lines = String.split(text, "\n")
    parse_items(lines, [])
  end

  defp parse_items([], list), do: Enum.reverse(list)
  defp parse_items([""], list), do: parse_items([], list)
  defp parse_items([h|t], list) do
    case Regex.split(~r{(?<num>] )(?<desc>)}, h) do
      [_num, desc] -> parse_items(t, [desc | list])
      _ -> parse_items(t, list)
    end
  end
end
