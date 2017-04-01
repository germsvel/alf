defmodule Alf.Storage do
  @dir_name "lists/"

  def store(text, filename) do
    ensure_directory_is_created()

    {:ok, file} = File.open(@dir_name <> filename, [:write])

    IO.write(file, text)
    File.close(file)
  end

  def get(filename) do
    File.read(@dir_name <> filename)
  end

  def clear_records do
    File.rm_rf(@dir_name)
  end

  defp ensure_directory_is_created do
    File.mkdir(@dir_name)
  end
end
