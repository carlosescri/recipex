defmodule Recipex.Timer do
  @moduledoc false

  @enforce_keys [:quantity, :unit]
  defstruct [:name] ++ @enforce_keys

  def to_string(%__MODULE__{quantity: quantity, unit: unit}),
    do: "#{quantity} #{unit}"
end
