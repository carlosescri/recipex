defmodule Recipex.Parser.Helpers do
  @moduledoc false

  import NimbleParsec

  alias Recipex.Parser.Chars

  @spec whitespace :: NimbleParsec.t()
  def whitespace do
    Chars.whitespace()
    |> utf8_string(min: 1)
    |> label("white space")
  end

  @spec newlines :: NimbleParsec.t()
  def newlines,
    do: utf8_string(Chars.newline(), min: 1)

  @spec blankspace :: NimbleParsec.t()
  def blankspace,
    do: utf8_string(Chars.whitespace() ++ Chars.newline(), min: 1)

  @spec negate(list) :: list
  def negate(char_list),
    do: Enum.map(char_list, &{:not, &1})

  @spec ignore_optional_whitespace(NimbleParsec.t()) :: NimbleParsec.t()
  def ignore_optional_whitespace(combinator \\ empty()) do
    combinator |> ignore(optional(whitespace()))
  end

  @spec ignore_newlines(NimbleParsec.t()) :: NimbleParsec.t()
  def ignore_newlines(combinator \\ empty()) do
    combinator |> ignore(newlines())
  end

  @spec text_chunk(NimbleParsec.t(), keyword) :: NimbleParsec.t()
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

  @spec word(NimbleParsec.t()) :: NimbleParsec.t()
  def word(combinator \\ empty()),
    do: text_chunk(combinator, exclude: Chars.whitespace() ++ Chars.punctuation() ++ [?~])
end
