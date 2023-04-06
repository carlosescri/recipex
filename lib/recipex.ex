defmodule Recipex do
  @moduledoc """
  Documentation for `Recipex`.
  """

  alias Recipex.Parser

  def parse(text) do
    with {:ok, [], "", recipe, _, _} = Parser.parse_recipe(text), do: recipe
  end
end