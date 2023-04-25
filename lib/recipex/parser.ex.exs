defmodule Recipex.Parser do
  @moduledoc false

  # parsec:Recipex.Parser
  import NimbleParsec

  alias Recipex.Parser.Chars
  alias Recipex.Parser.Utils

  init = post_traverse(empty(), {Utils, :build_recipe, []})

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

  # TODO: use Unicode lib instead of Chars
  defcombinatorp(
    :component_word_allowed_char,
    lookahead_not(utf8_char(Chars.newline() ++ Chars.whitespace() ++ Chars.punctuation()))
  )

  component_word =
    parsec(:component_word_allowed_char)
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
    |> concat(
      choice([
        multi_word_component,
        one_word_component
      ])
    )
    |> tag(:ingredient)

  cookware =
    empty()
    |> ignore(string("#"))
    |> concat(
      choice([
        multi_word_component,
        one_word_component
      ])
    )
    |> tag(:cookware)

  timer =
    empty()
    |> ignore(string("~"))
    |> concat(
      choice([
        multi_word_component,
        one_word_component,
        no_name_component
      ])
    )
    |> tag(:timer)

  inline_text =
    empty()
    |> lookahead_not(
      choice([string("--"), string("[-"), utf8_char(Chars.newline() ++ [?@, ?#, ?~, ?{, ?}])])
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

  comment_block =
    choice([
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

  defparsec(:parse_recipe, repeat(init, post_traverse(block, {Utils, :process_block, []})))

  # parsec:Recipex.Parser
end
