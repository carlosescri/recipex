defmodule Recipex.Text do
  @moduledoc false

  @enforce_keys [:value]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          value: binary
        }

  defimpl String.Chars do
    @spec to_string(Recipex.Text.t()) :: binary
    def to_string(text), do: text.value
  end
end
