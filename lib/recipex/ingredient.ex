defmodule Recipex.Ingredient do
  @moduledoc false

  alias Recipex.Parser.Utils, as: ParserUtils

  defstruct [:quantity, :units, name: ""]

  def new(opts \\ []) do
    opts
    |> Map.new(&ParserUtils.parse_value/1)
    |> then(&struct(__MODULE__, &1))
  end

  defimpl String.Chars do
    def to_string(ingredient), do: ingredient.name
  end
end
