defmodule Recipex.Parser do
  @moduledoc false

  import NimbleParsec
  import Recipex.Parser.Helpers

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Recipe
  alias Recipex.Timer

  init = post_traverse(empty(), :build_recipe)

  block =
    choice([
      metadata(),
      comment(),
      step()
    ])

  defparsec :parse_recipe, repeat(init, post_traverse(block, :process_block))

  defp build_recipe(rest, args, context, _line, _offset) do
    {rest, args, struct(Recipe, context)}
  end

  defp process_block(rest, [comment: comment], %Recipe{} = context, _line, _offset) do
    {rest, [], Recipe.register_step(context, {:comment, String.trim(comment)})}
  end

  defp process_block(rest, [metadata: [key, value]], %Recipe{} = context, _line, _offset) do
    {rest, [], Recipe.register_metadata(context, key, value)}
  end

  defp process_block(rest, [step: step], %Recipe{} = context, _line, _offset) do
    {step, context} =
      Enum.map_reduce(step, context, fn
        str, acc when is_binary(str) ->
          {str, acc}

        {:ingredient, ingredient}, acc ->
          ingredient = struct(Ingredient, ingredient)
          {Ingredient.to_string(ingredient), Recipe.add_ingredient(acc, ingredient)}

        {:cookware, cookware}, acc ->
          cookware = struct(Cookware, cookware)
          {Cookware.to_string(cookware), Recipe.add_cookware(acc, cookware)}

        {:timer, timer}, acc ->
          timer = struct(Timer, timer)
          {Timer.to_string(timer), Recipe.add_timer(acc, timer)}

        {:comment, comment}, acc ->
          {{:comment, String.trim(comment)}, acc}
      end)

    {rest, [], Recipe.register_step(context, {:step, reduce_step(step)})}
  end

  defp reduce_step([]), do: []

  defp reduce_step(step) do
    case Enum.split_while(step, &is_binary(&1)) do
      {str_list, [b | c]} -> [Enum.join(str_list), b] ++ reduce_step(c)
      {str_list, []} -> [str_list |> Enum.join() |> String.trim()]
    end
  end
end
