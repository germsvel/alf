defmodule Alf.Storage do
  def store(text, file_name) do
    {:ok, file} = File.open(file_name, [:write])
    IO.write(file, text)
    File.close(file)
  end
end
