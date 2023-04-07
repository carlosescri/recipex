defmodule Recipex.Timer do
  @moduledoc false

  @enforce_keys [:quantity, :units]
  defstruct [:name] ++ @enforce_keys

  defimpl String.Chars do
    def to_string(timer), do: "#{timer.quantity} #{timer.units}"
  end
end
