defmodule Recipex do
  @moduledoc """
  Documentation for `Recipex`.
  """

  alias Recipex.Parser
  alias Recipex.Recipe

  @spec parse(binary, any) ::
          {:ok, list, binary, map, {pos_integer, pos_integer}, pos_integer} | map
  def parse(text, opts \\ []) do
    with {:ok, [], "", recipe, _, _} <- Parser.parse_recipe(text) do
      if Keyword.get(opts, :reduce, false) do
        Recipe.reduce_steps(recipe)
      else
        recipe
      end
    end
  end

  @spec parse_file(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            ),
          any
        ) :: {:ok, list, binary, map, {pos_integer, pos_integer}, pos_integer} | map
  def parse_file(path, opts \\ []) do
    path |> File.read!() |> parse(opts)
  end
end
