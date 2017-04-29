defmodule Alf.Storage do
  @dir_name "lists/"

  def store(text, filename) do
    ensure_directory_is_created()

    {:ok, file} = File.open(storage_name(filename), [:write])

    IO.write(file, text)
    File.close(file)
  end

  def get(filename) do
    case File.read(storage_name(filename)) do
      {:ok, text} -> text
      _ -> ""
    end
  end

  def clear_records do
    File.rm_rf(@dir_name)
  end

  defp storage_name(filename) do
    @dir_name <> filename <> Atom.to_string(Mix.env)
  end

  defp ensure_directory_is_created do
    File.mkdir(@dir_name)
  end
end
