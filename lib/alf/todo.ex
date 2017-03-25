defmodule Alf.Todo do
  defstruct [:description, :position]

  def new(description, position) do
    %Alf.Todo{description: description, position: position}
  end
end
