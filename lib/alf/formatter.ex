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
end
