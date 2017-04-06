defmodule Alf.AutoSaver do
  use GenServer

  @name __MODULE__

  def start_link do
    GenServer.start_link(@name, %{}, name: @name)
  end

  def init(state) do
    schedule_save()
    {:ok, state}
  end

  def handle_info(:save_lists, state) do
    Alf.TodoList.save()
    schedule_save()
    {:noreply, state}
  end

  defp schedule_save do
    Process.send_after(self(), :save_lists, 1000)
  end
end
