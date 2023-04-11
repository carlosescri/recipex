defmodule Recipex do
  @moduledoc """
  Documentation for `Recipex`.
  """

  alias Recipex.Parser
  alias Recipex.Recipe

  def parse(text, opts \\ []) do
    with {:ok, [], "", recipe, _, _} <- Parser.parse_recipe(text) do
      if Keyword.get(opts, :reduce, false) do
        Recipe.reduce_steps(recipe)
      else
        recipe
      end
    end
  end

  def parse_file(path, opts \\ []) do
    path |> File.read!() |> parse(opts)
  end
end
