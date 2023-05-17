defmodule Recipex.Parser.Chars do
  @moduledoc false

  # Unicode Category: Zs
  @space_separator Unicode.Set.to_utf8_char!("[:Zs:]")
  # Unicode Category: Pc
  @connector_punctuation Unicode.Set.to_utf8_char!("[:Pc:]")
  # Unicode Category: Pd
  # @dash_punctuation Unicode.Set.to_utf8_char!("[:Pd:]")
  # Unicode Category: Pe
  @close_punctuation Unicode.Set.to_utf8_char!("[:Pe:]")
  # Unicode Category: Pf
  @final_punctuation Unicode.Set.to_utf8_char!("[:Pf:]")
  # Unicode Category: Pi
  @initial_punctuation Unicode.Set.to_utf8_char!("[:Pi:]")
  # Unicode Category: Po
  @other_punctuation Unicode.Set.to_utf8_char!("[:Po:]")
  # Unicode Category: Ps
  @open_punctuation Unicode.Set.to_utf8_char!("[:Ps:]")
  # Unicode Category: CC (partially), Zl, Zp
  @line_separator [0x000A..0x000D, 0x0085, 0x2028, 0x2029]

  @doc false
  @spec punctuation :: list
  def punctuation,
    do:
      @close_punctuation ++
        @connector_punctuation ++
        @final_punctuation ++
        @initial_punctuation ++
        @open_punctuation ++
        @other_punctuation

  @doc false
  @spec whitespace :: list
  def whitespace, do: @space_separator

  @doc false
  @spec newline :: list
  def newline, do: @line_separator
end
