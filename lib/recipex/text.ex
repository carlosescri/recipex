defmodule Recipex.Text do
  @moduledoc false

  @enforce_keys [:value]
  defstruct @enforce_keys

  defimpl String.Chars do
    def to_string(text), do: text.value
  end
end
