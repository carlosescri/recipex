defmodule Recipex.Parser do
  @moduledoc false

  import NimbleParsec
  import Recipex.Parser.Helpers

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Recipe
  alias Recipex.Text
  alias Recipex.Timer

  init = post_traverse(empty(), :build_recipe)

  metadata_start = string(">>")

  comment_start = string("--")

  multiline_comment_start = string("[-")

  multiline_comment_end = string("-]")

  ingredient_start = string("@")

  cookware_start = string("#")

  timer_start = string("~")

  qty_unit_separator = string("%")

  metadata_block =
    ignore(metadata_start)
    |> ignore_optional_whitespace()
    |> text_chunk(exclude: [?:])
    |> ignore(utf8_char([?:]))
    |> ignore_optional_whitespace()
    |> text_chunk(min: 0)
    |> tag(:metadata)

  inline_comment =
    ignore(comment_start)
    |> ignore_optional_whitespace()
    |> text_chunk(min: 0)
    |> unwrap_and_tag(:comment)

  inline_multiline_comment =
    ignore(multiline_comment_start)
    |> repeat(utf8_char(lookahead_not(multiline_comment_end), []))
    |> ignore(multiline_comment_end)
    |> ignore_optional_whitespace()
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:comment)

  comment_block = choice([inline_comment, inline_multiline_comment])

  quantity =
    text_chunk(empty(), exclude: [?%, ?}])
    |> label("quantity")
    |> unwrap_and_tag(:quantity)

  unit =
    text_chunk(empty(), exclude: [?}])
    |> label("unit")
    |> unwrap_and_tag(:units)

  amount =
    choice([
      quantity |> ignore(qty_unit_separator) |> concat(unit),
      quantity
    ])

  no_name_component =
    ignore(string("{"))
    |> concat(optional(amount))
    |> ignore(string("}"))

  one_word_component =
    word()
    |> unwrap_and_tag(:name)
    |> concat(optional(no_name_component))

  multi_word_component =
    word()
    |> repeat(choice([word(), whitespace()]))
    |> reduce({Enum, :join, [""]})
    |> unwrap_and_tag(:name)
    |> concat(no_name_component)

  ingredient =
    ignore(ingredient_start)
    |> choice([
      multi_word_component,
      one_word_component
    ])
    |> label("ingredient like @text, @text{2} @text text{}, @text{2%cups}")
    |> tag(:ingredient)

  cookware =
    ignore(cookware_start)
    |> choice([
      multi_word_component,
      one_word_component
    ])
    |> label("cookware like #frying pan{} or #bowl")
    |> tag(:cookware)

  timer =
    ignore(timer_start)
    |> choice([
      multi_word_component,
      one_word_component,
      no_name_component
    ])
    |> label("timer like ~{2%minutes} or ~text{2%minutes}")
    |> tag(:timer)

  inline_text =
    text_chunk(
      empty(),
      exclude: [?@, ?#, ?~],
      break_at: choice([comment_start, multiline_comment_start])
    )

  step_block =
    repeat(
      choice([
        ingredient,
        cookware,
        timer,
        inline_multiline_comment,
        inline_comment,
        inline_text
      ])
    )
    |> tag(:step)

  block = ignore_newlines(choice([metadata_block, comment_block, step_block]))

  defparsec(:parse_recipe, repeat(init, post_traverse(block, :process_block)))

  defp build_recipe(rest, args, context, _line, _offset) do
    {rest, args, struct(Recipe, context)}
  end

  defp process_block(rest, [comment: _comment], %Recipe{} = context, _line, _offset) do
    {rest, [], context}
  end

  defp process_block(rest, [metadata: [key, value]], %Recipe{} = context, _line, _offset) do
    {rest, [], Recipe.add_metadata(context, key, value)}
  end

  defp process_block(rest, [step: step], %Recipe{} = context, _line, _offset) do
    {step, context} =
      Enum.map_reduce(step, context, fn
        text, acc when is_binary(text) ->
          {text, acc}

        {:ingredient, ingredient}, acc ->
          ingredient = struct(Ingredient, ingredient)
          {ingredient, Recipe.add_ingredient(acc, ingredient)}

        {:cookware, cookware}, acc ->
          cookware = struct(Cookware, cookware)
          {cookware, Recipe.add_cookware(acc, cookware)}

        {:timer, timer}, acc ->
          timer = struct(Timer, timer)
          {timer, Recipe.add_timer(acc, timer)}

        {:comment, _comment}, acc ->
          {"", acc}
      end)

    {rest, [], Recipe.add_step(context, reduce_step(step))}
  end

  defp reduce_step([]), do: []

  defp reduce_step(step) do
    case Enum.split_while(step, &is_binary(&1)) do
      {str_list, [b | c]} -> [to_text(str_list), b] ++ reduce_step(c)
      {str_list, []} -> [to_text(str_list)]
    end
  end

  defp to_text(str_list) do
    value = str_list |> Enum.join()
    %Text{value: value}
  end
end
