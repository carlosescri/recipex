defmodule Recipex.Parser do
  @moduledoc false

  import NimbleParsec

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Parser.Chars
  alias Recipex.Recipe
  alias Recipex.Text
  alias Recipex.Timer

  init = post_traverse(empty(), :build_recipe)

  some_whitespace = utf8_string(Chars.whitespace(), min: 1)

  quantity =
    empty()
    |> lookahead_not(utf8_char([?%, ?}]))
    |> utf8_char([])
    |> times(min: 1)
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:quantity)

  units =
    lookahead_not(utf8_char([?}]))
    |> utf8_char([])
    |> times(min: 1)
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:units)

  amount = quantity |> optional(ignore(string("%")) |> concat(units))

  component_word =
    empty()
    # Adding Chars.punctuation() here increases compile time a lot.
    # TODO: add punctuation when we compile the parser from a .exs template.
    |> lookahead_not(
      utf8_char(
        Chars.newline() ++
          Chars.whitespace() ++
          [?{, ?}, ?@, ?#, ?~]
      )
    )
    |> utf8_char([])
    |> times(min: 1)
    |> reduce({List, :to_string, []})

  no_name_component =
    ignore(string("{"))
    |> concat(optional(amount))
    |> ignore(string("}"))

  one_word_component =
    component_word
    |> unwrap_and_tag(:name)
    |> concat(optional(no_name_component))

  multi_word_component =
    component_word
    |> times(concat(some_whitespace, component_word), min: 1)
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:name)
    |> concat(no_name_component)

  ingredient =
    empty()
    |> ignore(string("@"))
    |> concat(choice([
      multi_word_component,
      one_word_component
    ]))
    |> tag(:ingredient)

  cookware =
    empty()
    |> ignore(string("#"))
    |> concat(choice([
      multi_word_component,
      one_word_component
    ]))
    |> tag(:cookware)

  timer =
    empty()
    |> ignore(string("~"))
    |> concat(choice([
      multi_word_component,
      one_word_component,
      no_name_component
    ]))
    |> tag(:timer)

  inline_text =
    empty()
    |> lookahead_not(
      choice([string("--"), string("[-"), utf8_char(Chars.newline() ++ [?@, ?#, ?~])])
    )
    |> utf8_char([])
    |> times(min: 1)
    |> reduce({List, :to_string, []})

  inline_comment =
    ignore(string("--"))
    |> times(
      lookahead_not(utf8_char(Chars.newline()))
      |> utf8_char([]),
      min: 1
    )
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:comment)

  inline_multiline_comment =
    ignore(string("[-"))
    |> times(
      lookahead_not(string("-]"))
      |> utf8_char([]),
      min: 1
    )
    |> ignore(string("-]"))
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:comment)

  comment_block = choice([
    inline_comment,
    inline_multiline_comment
  ])

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

  metadata_block =
    ignore(string(">>"))
    |> concat(
      lookahead_not(string(":"))
      |> utf8_char([])
      |> times(min: 1)
      |> reduce({List, :to_string, []})
    )
    |> ignore(string(":"))
    |> concat(
      lookahead_not(utf8_char(Chars.newline()))
      |> utf8_char([])
      |> times(min: 1)
      |> reduce({List, :to_string, []})
    )
    |> tag(:metadata)

  block =
    choice([
      metadata_block,
      comment_block,
      step_block
    ])
    |> ignore(utf8_string(Chars.newline(), min: 1))

  defparsec(:parse_recipe, repeat(init, post_traverse(block, :process_block)))

  @spec build_recipe(binary, list, map, term, term) :: {binary, list, Recipe.t()}
  defp build_recipe(rest, args, context, _line, _offset) do
    {rest, args, struct(Recipe, context)}
  end

  @spec process_block(binary, list, Recipe.t(), term, term) :: {binary, [], Recipe.t()}
  defp process_block(rest, [comment: _comment], %Recipe{} = context, _line, _offset) do
    {rest, [], context}
  end

  defp process_block(rest, [metadata: [key, value]], %Recipe{} = context, _line, _offset) do
    {rest, [], Recipe.add_metadata(context, String.trim(key), String.trim(value))}
  end

  defp process_block(rest, [step: step], %Recipe{} = context, _line, _offset) do
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
end
