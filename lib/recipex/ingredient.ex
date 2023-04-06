defmodule Recipex.Ingredient do
  @moduledoc false

  @enforce_keys [:name]
  defstruct @enforce_keys ++ [:quantity, :unit]

  def to_string(%__MODULE__{name: name}), do: name
end
