defmodule Recipex.Ingredient do
  @moduledoc false

  @enforce_keys [:name]
  defstruct @enforce_keys ++ [:quantity, :units]

  defimpl String.Chars do
    def to_string(ingredient), do: ingredient.name
  end
end
