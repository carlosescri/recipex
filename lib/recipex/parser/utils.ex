defmodule Recipex.Parser.Utils do
  @moduledoc false

  @fraction_regex ~r/^([1-9]\d*)\s*\/\s*([1-9]\d*)$/

  def new_component(module, opts) do
    opts
    |> Map.new(&parse_value/1)
    |> then(&struct(module, &1))
  end

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

  def parse_quantity(str_value) do
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

  def apply_fraction(str_value) do
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
