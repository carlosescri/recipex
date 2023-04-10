defmodule Recipex.Cookware do
  @moduledoc false

  alias Recipex.Parser.Utils, as: ParserUtils

  defstruct [quantity: 1, name: ""]

  def new(opts \\ []) do
    quantity =
      opts
      |> Keyword.get(:quantity, "")
      |> String.trim()

    opts =
      case quantity do
        "" -> Keyword.delete(opts, :quantity)
        value -> Keyword.put(opts, :quantity, String.trim(value))
      end

    opts
    |> Map.new(&ParserUtils.parse_value/1)
    |> then(&struct(__MODULE__, &1))
  end

  defimpl String.Chars do
    def to_string(cookware), do: cookware.name
  end
end
