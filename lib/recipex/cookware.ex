defmodule Recipex.Cookware do
  @moduledoc false

  @enforce_keys [:name]
  defstruct @enforce_keys ++ [quantity: 1]

  def to_string(%__MODULE__{name: name}), do: name
end
