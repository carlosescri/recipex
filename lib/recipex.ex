defmodule Recipex do
  @moduledoc """
  Documentation for `Recipex`.
  """

  alias Recipex.Parser
  alias Recipex.Recipe

  @spec parse(binary, any) :: {:ok, Recipe.t()} | {:error, term}
  def parse(text, opts \\ []) do
    case Parser.parse_recipe(text) do
      {:ok, [], "", recipe, _, _} ->
        recipe =
          if Keyword.get(opts, :reduce, false) do
            Recipe.reduce_steps(recipe)
          else
            recipe
          end

        {:ok, recipe}

      other ->
        {:error, other}
    end
  end

  @spec parse_file(binary, keyword) :: {:ok, Recipe.t()} | {:error, term}
  def parse_file(path, opts \\ []) do
    path |> File.read!() |> parse(opts)
  end
end
