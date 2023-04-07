defmodule Recipex.Parser.Helpers do
  @moduledoc false

  import NimbleParsec

  alias Recipex.Parser.Chars

  def whitespace,
    do: utf8_string(Chars.whitespace(), min: 1)

  def newlines,
    do: utf8_string(Chars.newline(), min: 1)

  def blankspace,
    do: utf8_string(Chars.whitespace() ++ Chars.newline(), min: 1)

  def negate(char_list),
    do: Enum.map(char_list, &{:not, &1})

  def ignore_optional_whitespace(combinator \\ empty()) do
    combinator |> ignore(optional(whitespace()))
  end

  def ignore_newlines(combinator \\ empty()) do
    combinator |> ignore(newlines())
  end

  def text_chunk(combinator \\ empty(), opts \\ []) when is_list(opts) do
    to_exclude = Keyword.get(opts, :exclude, [])
    min_length = Keyword.get(opts, :min, 1)

    case Keyword.get(opts, :break_at) do
      nil ->
        utf8_string(combinator, negate(Chars.newline() ++ to_exclude), min: min_length)

      break_at_combinator ->
        lookahead_not(break_at_combinator)
        |> utf8_char(negate(Chars.newline() ++ to_exclude))
        |> times(min: max(1, min_length))
        |> reduce({List, :to_string, []})
    end
  end

  def word(combinator \\ empty()),
    do: text_chunk(combinator, exclude: Chars.whitespace() ++ Chars.punctuation() ++ [?~])
end
