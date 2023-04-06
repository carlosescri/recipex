defmodule Recipex.Parser.Helpers do
  @moduledoc false

  # TODO: Could we use Unicode.Set.* and repeat_while to check unicode category?

  import NimbleParsec

  alias Recipex.Chars

  def whitespace,
    do: utf8_string(Chars.whitespace(), min: 1)

  def newlines,
    do: utf8_string(Chars.newline(), min: 1)

  def blankspace,
    do: utf8_string(Chars.whitespace() ++ Chars.newline(), min: 1)

  def metadata do
    ignore(string(">>"))
    |> ignore(optional(whitespace()))
    |> utf8_string(negate(Chars.newline() ++ [?:]), min: 1)
    |> ignore(utf8_char([?:]))
    |> ignore(optional(whitespace()))
    |> utf8_string(negate(Chars.newline()), min: 0)
    |> ignore(newlines())
    |> tag(:metadata)
  end

  def comment,
    do: choice([line_comment(), block_comment()])

  def component(chr, require_word \\ true) do
    choices = [
      multi_word_component(),
      one_word_component()
    ] ++ if(require_word, do: [], else: [no_name_component()])

    chr
    |> string()
    |> ignore()
    |> choice(choices)
  end

  def ingredient do
    component("@")
    |> label("ingredient like @text{quantity%unit}")
    |> tag(:ingredient)
  end

  def timer do
    component("~", false)
    |> label("timer like ~{2%minutes} or ~text{2%minutes}")
    |> tag(:timer)
  end

  def cookware do
    component("#")
    |> label("cookware like #frying pan{1}")
    |> tag(:cookware)
  end

  def text_fragment do
    lookahead_not(choice([string("--"), string("[-")]))
    |> utf8_char(negate(Chars.newline() ++ [?@, ?#, ?~]))
    |> times(min: 1)
    |> reduce({List, :to_string, []})
  end

  def step do
    repeat(
      choice([
        ingredient(),
        cookware(),
        timer(),
        inline_block_comment(),
        inline_comment(),
        text_fragment()
      ])
    )
    |> optional(inline_comment())
    |> ignore(utf8_string(Chars.newline(), min: 1))
    |> tag(:step)
  end

  defp quantity do
    utf8_string(negate(Chars.newline() ++ [?%, ?}]), min: 1)
    |> label("quantity")
    |> unwrap_and_tag(:quantity)
  end

  defp unit do
    utf8_string(negate(Chars.newline() ++ [?}]), min: 1)
    |> label("unit")
    |> unwrap_and_tag(:unit)
  end

  defp amount do
    choice([
      quantity() |> concat(ignore(string("%"))) |> concat(unit()),
      quantity()
    ])
    |> label("amount")
  end

  defp word do
    utf8_string(negate(Chars.newline() ++ Chars.whitespace() ++ Chars.punctuation() ++ [?~]), min: 1)
    |> label("word")
  end

  defp no_name_component do
    ignore(string("{"))
    |> concat(optional(amount()))
    |> ignore(string("}"))
    |> label("no name component")
  end

  defp one_word_component do
    concat(unwrap_and_tag(word(), :name), optional(no_name_component()))
  end

  defp multi_word_component do
    word()
    |> repeat(choice([word(), whitespace()]))
    |> reduce({Enum, :join, [""]})
    |> unwrap_and_tag(:name)
    |> concat(no_name_component())
  end

  defp inline_comment do
    ignore(string("--"))
    |> ignore(optional(whitespace()))
    |> utf8_string(negate(Chars.newline()), min: 0)
    |> unwrap_and_tag(:comment)
  end

  defp inline_block_comment do
    ignore(string("[-"))
    |> repeat(utf8_char(lookahead_not(string("-]")), []))
    |> ignore(string("-]"))
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:comment)
  end

  defp line_comment,
    do: ignore(inline_comment(), optional(newlines()))

  defp block_comment,
    do: ignore(inline_block_comment(), optional(newlines()))

  defp negate(char_list),
    do: Enum.map(char_list, &{:not, &1})
end
