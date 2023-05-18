defmodule Recipex.Parser.Utils do
  @moduledoc false

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Recipe
  alias Recipex.Text
  alias Recipex.Timer

  @fraction_regex ~r/^([1-9]\d*)\s*\/\s*([1-9]\d*)$/

  @spec parse_value({atom, binary}) :: {atom, term}
  def parse_value({:name, name}) when is_binary(name),
    do: {:name, String.trim(name)}

  def parse_value({:name, name}),
    do: to_string(name)

  def parse_value({:quantity, quantity}) when is_binary(quantity) do
    case parse_quantity(quantity) do
      "" -> {:quantity, nil}
      value -> {:quantity, value}
    end
  end

  def parse_value({:units, units}), do: {:units, String.trim(units)}

  def parse_value(value), do: value

  @spec build_recipe(binary, list, map, term, term) :: {binary, list, Recipe.t()}
  def build_recipe(rest, args, context, _line, _offset) do
    {rest, args, struct(Recipe, context)}
  end

  @spec process_block(binary, list, Recipe.t(), term, term) :: {binary, [], Recipe.t()}
  def process_block(rest, [comment: _comment], %Recipe{} = context, _line, _offset) do
    {rest, [], context}
  end

  def process_block(rest, [metadata: [key, value]], %Recipe{} = context, _line, _offset) do
    {rest, [], Recipe.add_metadata(context, String.trim(key), String.trim(value))}
  end

  def process_block(rest, [step: step], %Recipe{} = context, _line, _offset) do
    {step, context} =
      Enum.map_reduce(step, context, fn
        text, acc when is_binary(text) ->
          {text, acc}

        {:ingredient, ingredient}, acc ->
          ingredient = Ingredient.new(ingredient)
          {ingredient, Recipe.add_ingredient(acc, ingredient)}

        {:cookware, cookware}, acc ->
          cookware = Cookware.new(cookware)
          {cookware, Recipe.add_cookware(acc, cookware)}

        {:timer, timer}, acc ->
          timer = Timer.new(timer)
          {timer, Recipe.add_timer(acc, timer)}

        {:comment, _comment}, acc ->
          {"", acc}
      end)

    {rest, [], Recipe.add_step(context, reduce_step(step))}
  end

  @spec reduce_step([Cookware.t() | Ingredient.t() | binary | Timer.t()]) :: [
          Cookware.t() | Ingredient.t() | Text.t() | Timer.t()
        ]
  defp reduce_step([]), do: []

  defp reduce_step(step) do
    case Enum.split_while(step, &is_binary(&1)) do
      {str_list, [b | c]} -> [to_text(str_list), b] ++ reduce_step(c)
      {str_list, []} -> [to_text(str_list)]
    end
    |> Enum.reject(&is_nil/1)
  end

  @spec to_text([binary]) :: nil | Text.t()
  defp to_text(str_list) do
    case Enum.join(str_list) do
      "" -> nil
      value -> %Text{value: value}
    end
  end

  # priv

  @spec parse_quantity(binary) :: binary | number
  defp parse_quantity(str_value) do
    str_value = String.trim(str_value)

    with :error <- apply_fraction(str_value),
         :error <- Float.parse(str_value) do
      str_value
    else
      {:ok, value} when is_number(value) ->
        value

      {float_value, ""} ->
        case Integer.parse(str_value) do
          {int_value, ""} when int_value == float_value -> int_value
          _ -> float_value
        end

      _ ->
        str_value
    end
  end

  @spec apply_fraction(binary) :: :error | {:ok, float}
  defp apply_fraction(str_value) do
    with [a, b] <- Regex.run(@fraction_regex, str_value, capture: :all_but_first),
         {a, ""} <- Float.parse(a),
         {b, ""} <- Float.parse(b) do
      {:ok, a / b}
    else
      _ -> :error
    end
  rescue
    ArithmeticError ->
      :error
  end
end
