defmodule Recipex.Ingredient do
  @moduledoc false

  alias Recipex.Parser.Utils, as: ParserUtils

  defstruct [:quantity, :units, name: ""]

  @type t :: %__MODULE__{
          quantity: number | binary | nil,
          units: binary | nil,
          name: binary
        }

  @spec new(list) :: t()
  def new(opts \\ []) do
    opts
    |> Map.new(&ParserUtils.parse_value/1)
    |> then(&struct(__MODULE__, &1))
  end

  defimpl String.Chars do
    @spec to_string(Recipex.Ingredient.t()) :: binary
    def to_string(ingredient), do: ingredient.name
  end
end
