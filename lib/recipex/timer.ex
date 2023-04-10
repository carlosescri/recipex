defmodule Recipex.Timer do
  @moduledoc false

  alias Recipex.Parser.Utils, as: ParserUtils

  defstruct [:quantity, :units, name: ""]

  def new(opts \\ []) do
    ParserUtils.new_component(__MODULE__, opts)
  end

  defimpl String.Chars do
    def to_string(timer), do: "#{timer.quantity} #{timer.units}"
  end
end
