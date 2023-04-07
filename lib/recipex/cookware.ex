defmodule Recipex.Cookware do
  @moduledoc false

  @enforce_keys [:name]
  defstruct @enforce_keys ++ [quantity: 1]

  defimpl String.Chars do
    def to_string(cookware), do: cookware.name
  end
end
