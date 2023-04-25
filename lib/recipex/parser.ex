# Generated from lib/recipex/parser.ex.exs, do not edit.
# Generated at 2023-04-25 20:02:29Z.

defmodule Recipex.Parser do
  @moduledoc false

  @doc """
  Parses the given `binary` as parse_recipe.

  Returns `{:ok, [token], rest, context, position, byte_offset}` or
  `{:error, reason, rest, context, line, byte_offset}` where `position`
  describes the location of the parse_recipe (start position) as `{line, offset_to_start_of_line}`.

  To column where the error occurred can be inferred from `byte_offset - offset_to_start_of_line`.

  ## Options

    * `:byte_offset` - the byte offset for the whole binary, defaults to 0
    * `:line` - the line and the byte offset into that line, defaults to `{1, byte_offset}`
    * `:context` - the initial context value. It will be converted to a map

  """
  @spec parse_recipe(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: pos_integer,
             rest: binary,
             reason: String.t(),
             context: map
  def parse_recipe(binary, opts \\ []) when is_binary(binary) do
    context = Map.new(Keyword.get(opts, :context, []))
    byte_offset = Keyword.get(opts, :byte_offset, 0)

    line =
      case Keyword.get(opts, :line, 1) do
        {_, _} = line -> line
        line -> {line, byte_offset}
      end

    case parse_recipe__0(binary, [], [], context, line, byte_offset) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp parse_recipe__0(rest, acc, stack, context, line, offset) do
    case (case Recipex.Parser.Utils.build_recipe(rest, [], context, line, offset) do
            {_, _, _} = res -> res
            {:error, reason} -> {:error, reason}
            {acc, context} -> {rest, acc, context}
          end) do
      {rest, user_acc, context} when is_list(user_acc) ->
        parse_recipe__1(rest, user_acc ++ acc, stack, context, line, offset)

      {:error, reason} ->
        {:error, reason, rest, context, line, offset}
    end
  end

  defp parse_recipe__1(rest, acc, stack, context, line, offset) do
    parse_recipe__3(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse_recipe__3(rest, acc, stack, context, line, offset) do
    parse_recipe__4(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__4(rest, acc, stack, context, line, offset) do
    parse_recipe__485(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__6(rest, acc, stack, context, line, offset) do
    parse_recipe__7(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__7(rest, acc, stack, context, line, offset) do
    parse_recipe__9(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse_recipe__9(rest, acc, stack, context, line, offset) do
    parse_recipe__330(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__11(rest, acc, stack, context, line, offset) do
    parse_recipe__12(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__12(<<"--", _::binary>> = rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__8(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__12(<<"[-", _::binary>> = rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__8(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__12(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 or x0 === 64 or
              x0 === 35 or
              x0 === 126 or x0 === 123 or x0 === 125 do
    [_, _, acc | stack] = stack
    parse_recipe__8(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__12(rest, acc, stack, context, line, offset) do
    parse_recipe__13(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__13(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__14(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__13(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__8(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__14(rest, acc, stack, context, line, offset) do
    parse_recipe__16(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__16(<<"--", _::binary>> = rest, acc, stack, context, line, offset) do
    parse_recipe__15(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__16(<<"[-", _::binary>> = rest, acc, stack, context, line, offset) do
    parse_recipe__15(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__16(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 or x0 === 64 or
              x0 === 35 or
              x0 === 126 or x0 === 123 or x0 === 125 do
    parse_recipe__15(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__16(rest, acc, stack, context, line, offset) do
    parse_recipe__17(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__17(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__18(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__17(rest, acc, stack, context, line, offset) do
    parse_recipe__15(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__15(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__19(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__18(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__16(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__19(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__20(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__20(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__21(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__11(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__22(rest, acc, stack, context, line, offset) do
    parse_recipe__23(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__23(rest, acc, stack, context, line, offset) do
    parse_recipe__24(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__24(<<"--", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__25(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__24(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__21(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__25(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    [_, acc | stack] = stack
    parse_recipe__21(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__25(rest, acc, stack, context, line, offset) do
    parse_recipe__26(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__26(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__27(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__26(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__21(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__27(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    parse_recipe__28(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__27(rest, acc, stack, context, line, offset) do
    parse_recipe__29(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__29(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__30(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__29(rest, acc, stack, context, line, offset) do
    parse_recipe__28(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__30(rest, acc, stack, context, line, offset) do
    parse_recipe__27(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__28(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__31(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__31(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__32(
      rest,
      [
        comment:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__32(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__33(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__22(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__34(rest, acc, stack, context, line, offset) do
    parse_recipe__35(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__35(rest, acc, stack, context, line, offset) do
    parse_recipe__36(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__36(<<"[-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__37(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__36(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__33(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__37(<<"-]", _::binary>> = rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__33(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__37(rest, acc, stack, context, line, offset) do
    parse_recipe__38(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__38(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__39(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__38(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__33(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__39(<<"-]", _::binary>> = rest, acc, stack, context, line, offset) do
    parse_recipe__40(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__39(rest, acc, stack, context, line, offset) do
    parse_recipe__41(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__41(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__42(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__41(rest, acc, stack, context, line, offset) do
    parse_recipe__40(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__42(rest, acc, stack, context, line, offset) do
    parse_recipe__39(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__40(<<"-]", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__43(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__40(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__33(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__43(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__44(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__44(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__45(
      rest,
      [
        comment:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__45(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__46(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__34(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__47(rest, acc, stack, context, line, offset) do
    parse_recipe__48(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__48(<<"~", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__49(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__48(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__46(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__49(rest, acc, stack, context, line, offset) do
    parse_recipe__128(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__51(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__52(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__51(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__46(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__52(rest, acc, stack, context, line, offset) do
    parse_recipe__56(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__54(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__53(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__55(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__54(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__56(rest, acc, stack, context, line, offset) do
    parse_recipe__57(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__57(rest, acc, stack, context, line, offset) do
    parse_recipe__58(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__58(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__55(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__58(rest, acc, stack, context, line, offset) do
    parse_recipe__59(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__59(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__60(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__59(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__55(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__60(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__61(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__60(rest, acc, stack, context, line, offset) do
    parse_recipe__62(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__62(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__63(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__62(rest, acc, stack, context, line, offset) do
    parse_recipe__61(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__63(rest, acc, stack, context, line, offset) do
    parse_recipe__60(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__61(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__64(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__64(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__65(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__65(rest, acc, stack, context, line, offset) do
    parse_recipe__69(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__67(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__66(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__68(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__67(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__69(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__70(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__69(rest, acc, stack, context, line, offset) do
    parse_recipe__68(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__70(rest, acc, stack, context, line, offset) do
    parse_recipe__71(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__71(rest, acc, stack, context, line, offset) do
    parse_recipe__72(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__72(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__68(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__72(rest, acc, stack, context, line, offset) do
    parse_recipe__73(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__73(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__74(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__73(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__68(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__74(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__75(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__74(rest, acc, stack, context, line, offset) do
    parse_recipe__76(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__76(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__77(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__76(rest, acc, stack, context, line, offset) do
    parse_recipe__75(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__77(rest, acc, stack, context, line, offset) do
    parse_recipe__74(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__75(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__78(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__78(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__79(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__79(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__66(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__66(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__53(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__53(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__80(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__53(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__46(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__80(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__50(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__81(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__51(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__82(rest, acc, stack, context, line, offset) do
    parse_recipe__83(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__83(rest, acc, stack, context, line, offset) do
    parse_recipe__84(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__84(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__85(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        parse_recipe__81(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__85(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__86(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__85(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__81(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__86(rest, acc, stack, context, line, offset) do
    parse_recipe__88(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__88(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__89(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__87(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__89(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__90(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__89(rest, acc, stack, context, line, offset) do
    parse_recipe__87(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__87(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__91(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__90(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__88(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__91(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__92(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__92(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__93(
      rest,
      [
        name:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__93(rest, acc, stack, context, line, offset) do
    parse_recipe__97(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__95(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__94(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__96(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__95(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__97(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__98(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__97(rest, acc, stack, context, line, offset) do
    parse_recipe__96(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__98(rest, acc, stack, context, line, offset) do
    parse_recipe__102(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__100(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__99(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__101(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__100(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__102(rest, acc, stack, context, line, offset) do
    parse_recipe__103(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__103(rest, acc, stack, context, line, offset) do
    parse_recipe__104(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__104(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__101(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__104(rest, acc, stack, context, line, offset) do
    parse_recipe__105(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__105(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__106(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__105(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__101(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__106(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__107(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__106(rest, acc, stack, context, line, offset) do
    parse_recipe__108(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__108(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__109(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__108(rest, acc, stack, context, line, offset) do
    parse_recipe__107(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__109(rest, acc, stack, context, line, offset) do
    parse_recipe__106(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__107(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__110(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__110(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__111(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__111(rest, acc, stack, context, line, offset) do
    parse_recipe__115(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__113(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__112(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__114(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__113(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__115(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__116(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__115(rest, acc, stack, context, line, offset) do
    parse_recipe__114(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__116(rest, acc, stack, context, line, offset) do
    parse_recipe__117(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__117(rest, acc, stack, context, line, offset) do
    parse_recipe__118(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__118(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__114(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__118(rest, acc, stack, context, line, offset) do
    parse_recipe__119(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__119(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__120(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__119(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__114(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__120(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__121(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__120(rest, acc, stack, context, line, offset) do
    parse_recipe__122(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__122(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__123(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__122(rest, acc, stack, context, line, offset) do
    parse_recipe__121(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__123(rest, acc, stack, context, line, offset) do
    parse_recipe__120(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__121(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__124(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__124(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__125(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__125(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__112(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__112(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__99(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__99(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__126(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__99(rest, acc, stack, context, line, offset) do
    parse_recipe__96(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__126(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__94(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__94(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__50(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__127(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__82(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__128(rest, acc, stack, context, line, offset) do
    parse_recipe__129(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__129(rest, acc, stack, context, line, offset) do
    parse_recipe__130(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__130(rest, acc, stack, context, line, offset) do
    parse_recipe__131(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__131(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__132(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, acc | stack] = stack
        parse_recipe__127(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__132(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__133(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__132(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__127(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__133(rest, acc, stack, context, line, offset) do
    parse_recipe__135(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__135(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__136(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__134(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__136(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__137(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__136(rest, acc, stack, context, line, offset) do
    parse_recipe__134(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__134(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__138(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__137(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__135(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__138(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__139(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__139(rest, acc, stack, context, line, offset) do
    parse_recipe__140(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__140(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__141(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__140(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__127(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__141(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__143(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__141(rest, acc, stack, context, line, offset) do
    parse_recipe__142(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__143(rest, acc, stack, context, line, offset) do
    parse_recipe__141(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__142(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__144(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__144(rest, acc, stack, context, line, offset) do
    parse_recipe__145(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__145(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__146(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, acc | stack] = stack
        parse_recipe__127(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__146(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__147(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__146(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__127(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__147(rest, acc, stack, context, line, offset) do
    parse_recipe__149(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__149(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__150(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__148(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__150(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__151(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__150(rest, acc, stack, context, line, offset) do
    parse_recipe__148(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__148(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__152(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__151(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__149(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__152(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__153(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__153(rest, acc, stack, context, line, offset) do
    parse_recipe__155(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__155(rest, acc, stack, context, line, offset) do
    parse_recipe__156(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__156(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__157(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__156(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__154(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__157(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__159(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__157(rest, acc, stack, context, line, offset) do
    parse_recipe__158(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__159(rest, acc, stack, context, line, offset) do
    parse_recipe__157(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__158(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__160(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__160(rest, acc, stack, context, line, offset) do
    parse_recipe__161(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__161(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__162(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        parse_recipe__154(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__162(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__163(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__162(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__154(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__163(rest, acc, stack, context, line, offset) do
    parse_recipe__165(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__165(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__166(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__164(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__166(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__167(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__166(rest, acc, stack, context, line, offset) do
    parse_recipe__164(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__164(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__168(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__167(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__165(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__168(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__169(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__154(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__170(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__169(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__155(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__170(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__171(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__171(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__172(
      rest,
      [
        name:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__172(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__173(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__172(rest, acc, stack, context, line, offset) do
    parse_recipe__127(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__173(rest, acc, stack, context, line, offset) do
    parse_recipe__177(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__175(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__174(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__176(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__175(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__177(rest, acc, stack, context, line, offset) do
    parse_recipe__178(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__178(rest, acc, stack, context, line, offset) do
    parse_recipe__179(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__179(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__176(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__179(rest, acc, stack, context, line, offset) do
    parse_recipe__180(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__180(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__181(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__180(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__176(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__181(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__182(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__181(rest, acc, stack, context, line, offset) do
    parse_recipe__183(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__183(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__184(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__183(rest, acc, stack, context, line, offset) do
    parse_recipe__182(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__184(rest, acc, stack, context, line, offset) do
    parse_recipe__181(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__182(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__185(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__185(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__186(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__186(rest, acc, stack, context, line, offset) do
    parse_recipe__190(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__188(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__187(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__189(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__188(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__190(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__191(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__190(rest, acc, stack, context, line, offset) do
    parse_recipe__189(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__191(rest, acc, stack, context, line, offset) do
    parse_recipe__192(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__192(rest, acc, stack, context, line, offset) do
    parse_recipe__193(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__193(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__189(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__193(rest, acc, stack, context, line, offset) do
    parse_recipe__194(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__194(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__195(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__194(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__189(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__195(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__196(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__195(rest, acc, stack, context, line, offset) do
    parse_recipe__197(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__197(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__198(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__197(rest, acc, stack, context, line, offset) do
    parse_recipe__196(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__198(rest, acc, stack, context, line, offset) do
    parse_recipe__195(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__196(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__199(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__199(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__200(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__200(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__187(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__187(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__174(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__174(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__201(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__174(rest, acc, stack, context, line, offset) do
    parse_recipe__127(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__201(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__50(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__50(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__202(
      rest,
      [timer: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__202(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__203(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__47(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__204(rest, acc, stack, context, line, offset) do
    parse_recipe__205(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__205(<<"#", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__206(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__205(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__203(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__206(rest, acc, stack, context, line, offset) do
    parse_recipe__254(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__208(rest, acc, stack, context, line, offset) do
    parse_recipe__209(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__209(rest, acc, stack, context, line, offset) do
    parse_recipe__210(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__210(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__211(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, _, _, acc | stack] = stack
        parse_recipe__203(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__211(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__212(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__211(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    parse_recipe__203(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__212(rest, acc, stack, context, line, offset) do
    parse_recipe__214(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__214(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__215(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__213(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__215(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__216(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__215(rest, acc, stack, context, line, offset) do
    parse_recipe__213(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__213(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__217(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__216(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__214(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__217(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__218(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__218(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__219(
      rest,
      [
        name:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__219(rest, acc, stack, context, line, offset) do
    parse_recipe__223(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__221(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__220(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__222(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__221(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__223(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__224(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__223(rest, acc, stack, context, line, offset) do
    parse_recipe__222(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__224(rest, acc, stack, context, line, offset) do
    parse_recipe__228(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__226(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__225(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__227(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__226(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__228(rest, acc, stack, context, line, offset) do
    parse_recipe__229(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__229(rest, acc, stack, context, line, offset) do
    parse_recipe__230(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__230(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__227(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__230(rest, acc, stack, context, line, offset) do
    parse_recipe__231(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__231(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__232(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__231(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__227(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__232(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__233(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__232(rest, acc, stack, context, line, offset) do
    parse_recipe__234(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__234(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__235(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__234(rest, acc, stack, context, line, offset) do
    parse_recipe__233(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__235(rest, acc, stack, context, line, offset) do
    parse_recipe__232(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__233(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__236(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__236(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__237(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__237(rest, acc, stack, context, line, offset) do
    parse_recipe__241(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__239(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__238(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__240(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__239(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__241(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__242(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__241(rest, acc, stack, context, line, offset) do
    parse_recipe__240(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__242(rest, acc, stack, context, line, offset) do
    parse_recipe__243(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__243(rest, acc, stack, context, line, offset) do
    parse_recipe__244(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__244(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__240(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__244(rest, acc, stack, context, line, offset) do
    parse_recipe__245(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__245(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__246(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__245(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__240(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__246(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__247(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__246(rest, acc, stack, context, line, offset) do
    parse_recipe__248(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__248(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__249(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__248(rest, acc, stack, context, line, offset) do
    parse_recipe__247(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__249(rest, acc, stack, context, line, offset) do
    parse_recipe__246(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__247(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__250(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__250(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__251(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__251(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__238(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__238(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__225(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__225(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__252(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__225(rest, acc, stack, context, line, offset) do
    parse_recipe__222(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__252(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__220(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__220(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__207(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__253(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__208(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__254(rest, acc, stack, context, line, offset) do
    parse_recipe__255(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__255(rest, acc, stack, context, line, offset) do
    parse_recipe__256(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__256(rest, acc, stack, context, line, offset) do
    parse_recipe__257(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__257(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__258(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, acc | stack] = stack
        parse_recipe__253(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__258(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__259(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__258(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__253(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__259(rest, acc, stack, context, line, offset) do
    parse_recipe__261(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__261(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__262(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__260(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__262(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__263(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__262(rest, acc, stack, context, line, offset) do
    parse_recipe__260(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__260(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__264(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__263(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__261(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__264(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__265(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__265(rest, acc, stack, context, line, offset) do
    parse_recipe__266(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__266(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__267(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__266(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__253(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__267(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__269(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__267(rest, acc, stack, context, line, offset) do
    parse_recipe__268(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__269(rest, acc, stack, context, line, offset) do
    parse_recipe__267(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__268(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__270(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__270(rest, acc, stack, context, line, offset) do
    parse_recipe__271(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__271(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__272(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, acc | stack] = stack
        parse_recipe__253(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__272(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__273(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__272(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__253(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__273(rest, acc, stack, context, line, offset) do
    parse_recipe__275(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__275(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__276(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__274(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__276(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__277(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__276(rest, acc, stack, context, line, offset) do
    parse_recipe__274(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__274(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__278(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__277(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__275(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__278(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__279(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__279(rest, acc, stack, context, line, offset) do
    parse_recipe__281(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__281(rest, acc, stack, context, line, offset) do
    parse_recipe__282(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__282(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__283(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__282(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__280(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__283(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__285(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__283(rest, acc, stack, context, line, offset) do
    parse_recipe__284(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__285(rest, acc, stack, context, line, offset) do
    parse_recipe__283(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__284(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__286(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__286(rest, acc, stack, context, line, offset) do
    parse_recipe__287(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__287(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__288(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        parse_recipe__280(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__288(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__289(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__288(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__280(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__289(rest, acc, stack, context, line, offset) do
    parse_recipe__291(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__291(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__292(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__290(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__292(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__293(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__292(rest, acc, stack, context, line, offset) do
    parse_recipe__290(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__290(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__294(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__293(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__291(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__294(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__295(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__280(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__296(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__295(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__281(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__296(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__297(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__297(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__298(
      rest,
      [
        name:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__298(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__299(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__298(rest, acc, stack, context, line, offset) do
    parse_recipe__253(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__299(rest, acc, stack, context, line, offset) do
    parse_recipe__303(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__301(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__300(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__302(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__301(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__303(rest, acc, stack, context, line, offset) do
    parse_recipe__304(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__304(rest, acc, stack, context, line, offset) do
    parse_recipe__305(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__305(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__302(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__305(rest, acc, stack, context, line, offset) do
    parse_recipe__306(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__306(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__307(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__306(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__302(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__307(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__308(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__307(rest, acc, stack, context, line, offset) do
    parse_recipe__309(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__309(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__310(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__309(rest, acc, stack, context, line, offset) do
    parse_recipe__308(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__310(rest, acc, stack, context, line, offset) do
    parse_recipe__307(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__308(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__311(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__311(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__312(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__312(rest, acc, stack, context, line, offset) do
    parse_recipe__316(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__314(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__313(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__315(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__314(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__316(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__317(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__316(rest, acc, stack, context, line, offset) do
    parse_recipe__315(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__317(rest, acc, stack, context, line, offset) do
    parse_recipe__318(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__318(rest, acc, stack, context, line, offset) do
    parse_recipe__319(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__319(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__315(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__319(rest, acc, stack, context, line, offset) do
    parse_recipe__320(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__320(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__321(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__320(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__315(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__321(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__322(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__321(rest, acc, stack, context, line, offset) do
    parse_recipe__323(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__323(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__324(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__323(rest, acc, stack, context, line, offset) do
    parse_recipe__322(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__324(rest, acc, stack, context, line, offset) do
    parse_recipe__321(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__322(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__325(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__325(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__326(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__326(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__313(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__313(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__300(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__300(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__327(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__300(rest, acc, stack, context, line, offset) do
    parse_recipe__253(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__327(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__207(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__207(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__328(
      rest,
      [cookware: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__328(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__329(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__204(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__330(rest, acc, stack, context, line, offset) do
    parse_recipe__331(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__331(<<"@", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__332(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__331(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__329(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__332(rest, acc, stack, context, line, offset) do
    parse_recipe__380(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__334(rest, acc, stack, context, line, offset) do
    parse_recipe__335(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__335(rest, acc, stack, context, line, offset) do
    parse_recipe__336(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__336(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__337(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, _, _, acc | stack] = stack
        parse_recipe__329(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__337(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__338(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__337(rest, _acc, stack, context, line, offset) do
    [_, _, _, _, acc | stack] = stack
    parse_recipe__329(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__338(rest, acc, stack, context, line, offset) do
    parse_recipe__340(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__340(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__341(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__339(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__341(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__342(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__341(rest, acc, stack, context, line, offset) do
    parse_recipe__339(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__339(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__343(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__342(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__340(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__343(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__344(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__344(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__345(
      rest,
      [
        name:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__345(rest, acc, stack, context, line, offset) do
    parse_recipe__349(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__347(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__346(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__348(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__347(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__349(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__350(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__349(rest, acc, stack, context, line, offset) do
    parse_recipe__348(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__350(rest, acc, stack, context, line, offset) do
    parse_recipe__354(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__352(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__351(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__353(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__352(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__354(rest, acc, stack, context, line, offset) do
    parse_recipe__355(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__355(rest, acc, stack, context, line, offset) do
    parse_recipe__356(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__356(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__353(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__356(rest, acc, stack, context, line, offset) do
    parse_recipe__357(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__357(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__358(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__357(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__353(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__358(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__359(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__358(rest, acc, stack, context, line, offset) do
    parse_recipe__360(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__360(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__361(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__360(rest, acc, stack, context, line, offset) do
    parse_recipe__359(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__361(rest, acc, stack, context, line, offset) do
    parse_recipe__358(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__359(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__362(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__362(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__363(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__363(rest, acc, stack, context, line, offset) do
    parse_recipe__367(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__365(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__366(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__365(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__367(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__368(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__367(rest, acc, stack, context, line, offset) do
    parse_recipe__366(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__368(rest, acc, stack, context, line, offset) do
    parse_recipe__369(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__369(rest, acc, stack, context, line, offset) do
    parse_recipe__370(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__370(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__366(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__370(rest, acc, stack, context, line, offset) do
    parse_recipe__371(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__371(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__372(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__371(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__366(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__372(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__373(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__372(rest, acc, stack, context, line, offset) do
    parse_recipe__374(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__374(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__375(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__374(rest, acc, stack, context, line, offset) do
    parse_recipe__373(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__375(rest, acc, stack, context, line, offset) do
    parse_recipe__372(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__373(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__376(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__376(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__377(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__377(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__364(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__364(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__351(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__351(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__378(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__351(rest, acc, stack, context, line, offset) do
    parse_recipe__348(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__378(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__346(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__346(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__333(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__379(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__334(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__380(rest, acc, stack, context, line, offset) do
    parse_recipe__381(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__381(rest, acc, stack, context, line, offset) do
    parse_recipe__382(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__382(rest, acc, stack, context, line, offset) do
    parse_recipe__383(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__383(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__384(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, acc | stack] = stack
        parse_recipe__379(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__384(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__385(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__384(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__379(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__385(rest, acc, stack, context, line, offset) do
    parse_recipe__387(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__387(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__388(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__386(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__388(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__389(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__388(rest, acc, stack, context, line, offset) do
    parse_recipe__386(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__386(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__390(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__389(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__387(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__390(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__391(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__391(rest, acc, stack, context, line, offset) do
    parse_recipe__392(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__392(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__393(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__392(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__379(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__393(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__395(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__393(rest, acc, stack, context, line, offset) do
    parse_recipe__394(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__395(rest, acc, stack, context, line, offset) do
    parse_recipe__393(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__394(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__396(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__396(rest, acc, stack, context, line, offset) do
    parse_recipe__397(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__397(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__398(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, _, acc | stack] = stack
        parse_recipe__379(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__398(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__399(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__398(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__379(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__399(rest, acc, stack, context, line, offset) do
    parse_recipe__401(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__401(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__402(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__400(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__402(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__403(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__402(rest, acc, stack, context, line, offset) do
    parse_recipe__400(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__400(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__404(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__403(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__401(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__404(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__405(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__405(rest, acc, stack, context, line, offset) do
    parse_recipe__407(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__407(rest, acc, stack, context, line, offset) do
    parse_recipe__408(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__408(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__409(
      rest,
      [<<x0::utf8>>] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__408(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__406(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__409(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 32 or x0 === 160 or x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or
              x0 === 8287 or x0 === 12288 do
    parse_recipe__411(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__409(rest, acc, stack, context, line, offset) do
    parse_recipe__410(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__411(rest, acc, stack, context, line, offset) do
    parse_recipe__409(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__410(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__412(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__412(rest, acc, stack, context, line, offset) do
    parse_recipe__413(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__413(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__414(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        parse_recipe__406(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__414(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__415(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__414(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__406(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__415(rest, acc, stack, context, line, offset) do
    parse_recipe__417(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__417(rest, acc, stack, context, line, offset) do
    case component_word_allowed_char__0(rest, acc, [], context, line, offset) do
      {:ok, acc, rest, context, line, offset} ->
        parse_recipe__418(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        parse_recipe__416(rest, acc, stack, context, line, offset)
    end
  end

  defp parse_recipe__418(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__419(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__418(rest, acc, stack, context, line, offset) do
    parse_recipe__416(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__416(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__420(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__419(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__417(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__420(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__421(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__406(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__422(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__421(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__407(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__422(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__423(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__423(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__424(
      rest,
      [
        name:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__424(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__425(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__424(rest, acc, stack, context, line, offset) do
    parse_recipe__379(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__425(rest, acc, stack, context, line, offset) do
    parse_recipe__429(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__427(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__426(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__428(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__427(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__429(rest, acc, stack, context, line, offset) do
    parse_recipe__430(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__430(rest, acc, stack, context, line, offset) do
    parse_recipe__431(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__431(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__428(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__431(rest, acc, stack, context, line, offset) do
    parse_recipe__432(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__432(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__433(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__432(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__428(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__433(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 37 or x0 === 125 do
    parse_recipe__434(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__433(rest, acc, stack, context, line, offset) do
    parse_recipe__435(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__435(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__436(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__435(rest, acc, stack, context, line, offset) do
    parse_recipe__434(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__436(rest, acc, stack, context, line, offset) do
    parse_recipe__433(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__434(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__437(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__437(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__438(
      rest,
      [
        quantity:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__438(rest, acc, stack, context, line, offset) do
    parse_recipe__442(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__440(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__439(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__441(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__440(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__442(<<"%", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__443(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__442(rest, acc, stack, context, line, offset) do
    parse_recipe__441(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__443(rest, acc, stack, context, line, offset) do
    parse_recipe__444(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__444(rest, acc, stack, context, line, offset) do
    parse_recipe__445(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__445(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 === 125 do
    [_, acc | stack] = stack
    parse_recipe__441(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__445(rest, acc, stack, context, line, offset) do
    parse_recipe__446(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__446(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__447(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__446(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__441(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__447(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 === 125 do
    parse_recipe__448(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__447(rest, acc, stack, context, line, offset) do
    parse_recipe__449(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__449(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__450(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__449(rest, acc, stack, context, line, offset) do
    parse_recipe__448(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__450(rest, acc, stack, context, line, offset) do
    parse_recipe__447(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__448(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__451(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__451(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__452(
      rest,
      [
        units:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__452(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__439(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__439(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__426(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__426(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__453(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__426(rest, acc, stack, context, line, offset) do
    parse_recipe__379(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__453(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__333(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__333(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__454(
      rest,
      [ingredient: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__454(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__8(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__455(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__10(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__9(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__455(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse_recipe__456(rest, [step: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse_recipe__456(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__5(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__457(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__6(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__458(rest, acc, stack, context, line, offset) do
    parse_recipe__473(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp parse_recipe__460(rest, acc, stack, context, line, offset) do
    parse_recipe__461(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__461(rest, acc, stack, context, line, offset) do
    parse_recipe__462(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__462(<<"[-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__463(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__462(rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    parse_recipe__457(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__463(<<"-]", _::binary>> = rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    parse_recipe__457(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__463(rest, acc, stack, context, line, offset) do
    parse_recipe__464(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__464(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__465(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__464(rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    parse_recipe__457(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__465(<<"-]", _::binary>> = rest, acc, stack, context, line, offset) do
    parse_recipe__466(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__465(rest, acc, stack, context, line, offset) do
    parse_recipe__467(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__467(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__468(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__467(rest, acc, stack, context, line, offset) do
    parse_recipe__466(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__468(rest, acc, stack, context, line, offset) do
    parse_recipe__465(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__466(<<"-]", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__469(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__466(rest, _acc, stack, context, line, offset) do
    [_, _, _, acc | stack] = stack
    parse_recipe__457(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__469(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__470(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__470(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__471(
      rest,
      [
        comment:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__471(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__459(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__472(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__460(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__473(rest, acc, stack, context, line, offset) do
    parse_recipe__474(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__474(rest, acc, stack, context, line, offset) do
    parse_recipe__475(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__475(<<"--", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__476(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__475(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__472(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__476(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    [_, acc | stack] = stack
    parse_recipe__472(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__476(rest, acc, stack, context, line, offset) do
    parse_recipe__477(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__477(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__478(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__477(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__472(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__478(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    parse_recipe__479(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__478(rest, acc, stack, context, line, offset) do
    parse_recipe__480(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__480(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__481(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__480(rest, acc, stack, context, line, offset) do
    parse_recipe__479(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__481(rest, acc, stack, context, line, offset) do
    parse_recipe__478(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__479(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__482(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__482(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__483(
      rest,
      [
        comment:
          case :lists.reverse(user_acc) do
            [one] -> one
            many -> raise "unwrap_and_tag/3 expected a single token, got: #{inspect(many)}"
          end
      ] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__483(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__459(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__459(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__5(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__484(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse_recipe__458(rest, [], stack, context, line, offset)
  end

  defp parse_recipe__485(rest, acc, stack, context, line, offset) do
    parse_recipe__486(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__486(<<">>", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__487(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse_recipe__486(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__484(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__487(rest, acc, stack, context, line, offset) do
    parse_recipe__488(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__488(<<":", _::binary>> = rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__484(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__488(rest, acc, stack, context, line, offset) do
    parse_recipe__489(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__489(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__490(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__489(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__484(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__490(<<":", _::binary>> = rest, acc, stack, context, line, offset) do
    parse_recipe__491(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__490(rest, acc, stack, context, line, offset) do
    parse_recipe__492(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__492(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__493(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__492(rest, acc, stack, context, line, offset) do
    parse_recipe__491(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__493(rest, acc, stack, context, line, offset) do
    parse_recipe__490(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__491(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__494(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__494(<<":", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse_recipe__495(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse_recipe__494(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse_recipe__484(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__495(rest, acc, stack, context, line, offset) do
    parse_recipe__496(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__496(<<x0::utf8, _::binary>> = rest, _acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    [_, acc | stack] = stack
    parse_recipe__484(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__496(rest, acc, stack, context, line, offset) do
    parse_recipe__497(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__497(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__498(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__497(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse_recipe__484(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__498(<<x0::utf8, _::binary>> = rest, acc, stack, context, line, offset)
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    parse_recipe__499(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__498(rest, acc, stack, context, line, offset) do
    parse_recipe__500(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__500(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse_recipe__501(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__500(rest, acc, stack, context, line, offset) do
    parse_recipe__499(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__501(rest, acc, stack, context, line, offset) do
    parse_recipe__498(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__499(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__502(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__502(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse_recipe__503(
      rest,
      [metadata: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse_recipe__503(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse_recipe__5(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse_recipe__5(rest, acc, stack, context, line, offset) do
    parse_recipe__504(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__504(rest, acc, stack, context, line, offset) do
    parse_recipe__505(rest, [], [acc | stack], context, line, offset)
  end

  defp parse_recipe__505(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    parse_recipe__506(
      rest,
      acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__505(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse_recipe__2(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__506(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 do
    parse_recipe__508(
      rest,
      acc,
      stack,
      context,
      (
        line = comb__line

        case x0 do
          10 -> {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}
          _ -> line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp parse_recipe__506(rest, acc, stack, context, line, offset) do
    parse_recipe__507(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__508(rest, acc, stack, context, line, offset) do
    parse_recipe__506(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__507(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse_recipe__509(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__509(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse_recipe__510(rest, [] ++ acc, stack, context, line, offset)
  end

  defp parse_recipe__510(rest, user_acc, [acc | stack], context, line, offset) do
    case (case Recipex.Parser.Utils.process_block(rest, user_acc, context, line, offset) do
            {_, _, _} = res -> res
            {:error, reason} -> {:error, reason}
            {acc, context} -> {rest, acc, context}
          end) do
      {rest, user_acc, context} when is_list(user_acc) ->
        parse_recipe__511(rest, user_acc ++ acc, stack, context, line, offset)

      {:error, reason} ->
        {:error, reason, rest, context, line, offset}
    end
  end

  defp parse_recipe__2(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse_recipe__512(rest, acc, stack, context, line, offset)
  end

  defp parse_recipe__511(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse_recipe__3(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse_recipe__512(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp component_word_allowed_char__0(
         <<x0::utf8, _::binary>> = rest,
         _acc,
         _stack,
         context,
         line,
         offset
       )
       when (x0 >= 10 and x0 <= 13) or x0 === 133 or x0 === 8232 or x0 === 8233 or x0 === 32 or
              x0 === 160 or
              x0 === 5760 or (x0 >= 8192 and x0 <= 8202) or x0 === 8239 or x0 === 8287 or
              x0 === 12288 or
              x0 === 41 or x0 === 93 or x0 === 125 or x0 === 3899 or x0 === 3901 or x0 === 5788 or
              x0 === 8262 or
              x0 === 8318 or x0 === 8334 or x0 === 8969 or x0 === 8971 or x0 === 9002 or
              x0 === 10089 or
              x0 === 10091 or x0 === 10093 or x0 === 10095 or x0 === 10097 or x0 === 10099 or
              x0 === 10101 or
              x0 === 10182 or x0 === 10215 or x0 === 10217 or x0 === 10219 or x0 === 10221 or
              x0 === 10223 or
              x0 === 10628 or x0 === 10630 or x0 === 10632 or x0 === 10634 or x0 === 10636 or
              x0 === 10638 or
              x0 === 10640 or x0 === 10642 or x0 === 10644 or x0 === 10646 or x0 === 10648 or
              x0 === 10713 or
              x0 === 10715 or x0 === 10749 or x0 === 11811 or x0 === 11813 or x0 === 11815 or
              x0 === 11817 or
              x0 === 12297 or x0 === 12299 or x0 === 12301 or x0 === 12303 or x0 === 12305 or
              x0 === 12309 or
              x0 === 12311 or x0 === 12313 or x0 === 12315 or x0 === 12318 or x0 === 12319 or
              x0 === 64830 or
              x0 === 65048 or x0 === 65078 or x0 === 65080 or x0 === 65082 or x0 === 65084 or
              x0 === 65086 or
              x0 === 65088 or x0 === 65090 or x0 === 65092 or x0 === 65096 or x0 === 65114 or
              x0 === 65116 or
              x0 === 65118 or x0 === 65289 or x0 === 65341 or x0 === 65373 or x0 === 65376 or
              x0 === 65379 or
              x0 === 95 or x0 === 8255 or x0 === 8256 or x0 === 8276 or x0 === 65075 or
              x0 === 65076 or
              x0 === 65101 or x0 === 65102 or x0 === 65103 or x0 === 65343 or x0 === 187 or
              x0 === 8217 or
              x0 === 8221 or x0 === 8250 or x0 === 11779 or x0 === 11781 or x0 === 11786 or
              x0 === 11789 or
              x0 === 11805 or x0 === 11809 or x0 === 171 or x0 === 8216 or x0 === 8219 or
              x0 === 8220 or
              x0 === 8223 or x0 === 8249 or x0 === 11778 or x0 === 11780 or x0 === 11785 or
              x0 === 11788 or
              x0 === 11804 or x0 === 11808 or x0 === 40 or x0 === 91 or x0 === 123 or x0 === 3898 or
              x0 === 3900 or x0 === 5787 or x0 === 8218 or x0 === 8222 or x0 === 8261 or
              x0 === 8317 or
              x0 === 8333 or x0 === 8968 or x0 === 8970 or x0 === 9001 or x0 === 10088 or
              x0 === 10090 or
              x0 === 10092 or x0 === 10094 or x0 === 10096 or x0 === 10098 or x0 === 10100 or
              x0 === 10181 or
              x0 === 10214 or x0 === 10216 or x0 === 10218 or x0 === 10220 or x0 === 10222 or
              x0 === 10627 or
              x0 === 10629 or x0 === 10631 or x0 === 10633 or x0 === 10635 or x0 === 10637 or
              x0 === 10639 or
              x0 === 10641 or x0 === 10643 or x0 === 10645 or x0 === 10647 or x0 === 10712 or
              x0 === 10714 or
              x0 === 10748 or x0 === 11810 or x0 === 11812 or x0 === 11814 or x0 === 11816 or
              x0 === 11842 or
              x0 === 12296 or x0 === 12298 or x0 === 12300 or x0 === 12302 or x0 === 12304 or
              x0 === 12308 or
              x0 === 12310 or x0 === 12312 or x0 === 12314 or x0 === 12317 or x0 === 64831 or
              x0 === 65047 or
              x0 === 65077 or x0 === 65079 or x0 === 65081 or x0 === 65083 or x0 === 65085 or
              x0 === 65087 or
              x0 === 65089 or x0 === 65091 or x0 === 65095 or x0 === 65113 or x0 === 65115 or
              x0 === 65117 or
              x0 === 65288 or x0 === 65339 or x0 === 65371 or x0 === 65375 or x0 === 65378 or
              x0 === 33 or
              x0 === 34 or x0 === 35 or x0 === 37 or x0 === 38 or x0 === 39 or x0 === 42 or
              x0 === 44 or
              x0 === 46 or x0 === 47 or x0 === 58 or x0 === 59 or x0 === 63 or x0 === 64 or
              x0 === 92 or
              x0 === 161 or x0 === 167 or x0 === 182 or x0 === 183 or x0 === 191 or x0 === 894 or
              x0 === 903 or
              x0 === 1370 or x0 === 1371 or x0 === 1372 or x0 === 1373 or x0 === 1374 or
              x0 === 1375 or
              x0 === 1417 or x0 === 1472 or x0 === 1475 or x0 === 1478 or x0 === 1523 or
              x0 === 1524 or
              x0 === 1545 or x0 === 1546 or x0 === 1548 or x0 === 1549 or x0 === 1563 or
              x0 === 1566 or
              x0 === 1567 or x0 === 1642 or x0 === 1643 or x0 === 1644 or x0 === 1645 or
              x0 === 1748 or
              x0 === 1792 or x0 === 1793 or x0 === 1794 or x0 === 1795 or x0 === 1796 or
              x0 === 1797 or
              x0 === 1798 or x0 === 1799 or x0 === 1800 or x0 === 1801 or x0 === 1802 or
              x0 === 1803 or
              x0 === 1804 or x0 === 1805 or x0 === 2039 or x0 === 2040 or x0 === 2041 or
              x0 === 2096 or
              x0 === 2097 or x0 === 2098 or x0 === 2099 or x0 === 2100 or x0 === 2101 or
              x0 === 2102 or
              x0 === 2103 or x0 === 2104 or x0 === 2105 or x0 === 2106 or x0 === 2107 or
              x0 === 2108 or
              x0 === 2109 or x0 === 2110 or x0 === 2142 or x0 === 2404 or x0 === 2405 or
              x0 === 2416 or
              x0 === 2557 or x0 === 2678 or x0 === 2800 or x0 === 3191 or x0 === 3204 or
              x0 === 3572 or
              x0 === 3663 or x0 === 3674 or x0 === 3675 or x0 === 3844 or x0 === 3845 or
              x0 === 3846 or
              x0 === 3847 or x0 === 3848 or x0 === 3849 or x0 === 3850 or x0 === 3851 or
              x0 === 3852 or
              x0 === 3853 or x0 === 3854 or x0 === 3855 or x0 === 3856 or x0 === 3857 or
              x0 === 3858 or
              x0 === 3860 or x0 === 3973 or x0 === 4048 or x0 === 4049 or x0 === 4050 or
              x0 === 4051 or
              x0 === 4052 or x0 === 4057 or x0 === 4058 or x0 === 4170 or x0 === 4171 or
              x0 === 4172 or
              x0 === 4173 or x0 === 4174 or x0 === 4175 or x0 === 4347 or x0 === 4960 or
              x0 === 4961 or
              x0 === 4962 or x0 === 4963 or x0 === 4964 or x0 === 4965 or x0 === 4966 or
              x0 === 4967 or
              x0 === 4968 or x0 === 5742 or x0 === 5867 or x0 === 5868 or x0 === 5869 or
              x0 === 5941 or
              x0 === 5942 or x0 === 6100 or x0 === 6101 or x0 === 6102 or x0 === 6104 or
              x0 === 6105 or
              x0 === 6106 or x0 === 6144 or x0 === 6145 or x0 === 6146 or x0 === 6147 or
              x0 === 6148 or
              x0 === 6149 or x0 === 6151 or x0 === 6152 or x0 === 6153 or x0 === 6154 or
              x0 === 6468 or
              x0 === 6469 or x0 === 6686 or x0 === 6687 or x0 === 6816 or x0 === 6817 or
              x0 === 6818 or
              x0 === 6819 or x0 === 6820 or x0 === 6821 or x0 === 6822 or x0 === 6824 or
              x0 === 6825 or
              x0 === 6826 or x0 === 6827 or x0 === 6828 or x0 === 6829 or x0 === 7002 or
              x0 === 7003 or
              x0 === 7004 or x0 === 7005 or x0 === 7006 or x0 === 7007 or x0 === 7008 or
              x0 === 7164 or
              x0 === 7165 or x0 === 7166 or x0 === 7167 or x0 === 7227 or x0 === 7228 or
              x0 === 7229 or
              x0 === 7230 or x0 === 7231 or x0 === 7294 or x0 === 7295 or x0 === 7360 or
              x0 === 7361 or
              x0 === 7362 or x0 === 7363 or x0 === 7364 or x0 === 7365 or x0 === 7366 or
              x0 === 7367 or
              x0 === 7379 or x0 === 8214 or x0 === 8215 or x0 === 8224 or x0 === 8225 or
              x0 === 8226 or
              x0 === 8227 or x0 === 8228 or x0 === 8229 or x0 === 8230 or x0 === 8231 or
              x0 === 8240 or
              x0 === 8241 or x0 === 8242 or x0 === 8243 or x0 === 8244 or x0 === 8245 or
              x0 === 8246 or
              x0 === 8247 or x0 === 8248 or x0 === 8251 or x0 === 8252 or x0 === 8253 or
              x0 === 8254 or
              x0 === 8257 or x0 === 8258 or x0 === 8259 or x0 === 8263 or x0 === 8264 or
              x0 === 8265 or
              x0 === 8266 or x0 === 8267 or x0 === 8268 or x0 === 8269 or x0 === 8270 or
              x0 === 8271 or
              x0 === 8272 or x0 === 8273 or x0 === 8275 or x0 === 8277 or x0 === 8278 or
              x0 === 8279 or
              x0 === 8280 or x0 === 8281 or x0 === 8282 or x0 === 8283 or x0 === 8284 or
              x0 === 8285 or
              x0 === 8286 or x0 === 11513 or x0 === 11514 or x0 === 11515 or x0 === 11516 or
              x0 === 11518 or
              x0 === 11519 or x0 === 11632 or x0 === 11776 or x0 === 11777 or x0 === 11782 or
              x0 === 11783 or
              x0 === 11784 or x0 === 11787 or x0 === 11790 or x0 === 11791 or x0 === 11792 or
              x0 === 11793 or
              x0 === 11794 or x0 === 11795 or x0 === 11796 or x0 === 11797 or x0 === 11798 or
              x0 === 11800 or
              x0 === 11801 or x0 === 11803 or x0 === 11806 or x0 === 11807 or x0 === 11818 or
              x0 === 11819 or
              x0 === 11820 or x0 === 11821 or x0 === 11822 or x0 === 11824 or x0 === 11825 or
              x0 === 11826 or
              x0 === 11827 or x0 === 11828 or x0 === 11829 or x0 === 11830 or x0 === 11831 or
              x0 === 11832 or
              x0 === 11833 or x0 === 11836 or x0 === 11837 or x0 === 11838 or x0 === 11839 or
              x0 === 11841 or
              x0 === 11843 or x0 === 11844 or x0 === 11845 or x0 === 11846 or x0 === 11847 or
              x0 === 11848 or
              x0 === 11849 or x0 === 11850 or x0 === 11851 or x0 === 11852 or x0 === 11853 or
              x0 === 11854 or
              x0 === 11855 or x0 === 11858 or x0 === 12289 or x0 === 12290 or x0 === 12291 or
              x0 === 12349 or
              x0 === 12539 or x0 === 42238 or x0 === 42239 or x0 === 42509 or x0 === 42510 or
              x0 === 42511 or
              x0 === 42611 or x0 === 42622 or x0 === 42738 or x0 === 42739 or x0 === 42740 or
              x0 === 42741 or
              x0 === 42742 or x0 === 42743 or x0 === 43124 or x0 === 43125 or x0 === 43126 or
              x0 === 43127 or
              x0 === 43214 or x0 === 43215 or x0 === 43256 or x0 === 43257 or x0 === 43258 or
              x0 === 43260 or
              x0 === 43310 or x0 === 43311 or x0 === 43359 or x0 === 43457 or x0 === 43458 or
              x0 === 43459 or
              x0 === 43460 or x0 === 43461 or x0 === 43462 or x0 === 43463 or x0 === 43464 or
              x0 === 43465 or
              x0 === 43466 or x0 === 43467 or x0 === 43468 or x0 === 43469 or x0 === 43486 or
              x0 === 43487 or
              x0 === 43612 or x0 === 43613 or x0 === 43614 or x0 === 43615 or x0 === 43742 or
              x0 === 43743 or
              x0 === 43760 or x0 === 43761 or x0 === 44011 or x0 === 65040 or x0 === 65041 or
              x0 === 65042 or
              x0 === 65043 or x0 === 65044 or x0 === 65045 or x0 === 65046 or x0 === 65049 or
              x0 === 65072 or
              x0 === 65093 or x0 === 65094 or x0 === 65097 or x0 === 65098 or x0 === 65099 or
              x0 === 65100 or
              x0 === 65104 or x0 === 65105 or x0 === 65106 or x0 === 65108 or x0 === 65109 or
              x0 === 65110 or
              x0 === 65111 or x0 === 65119 or x0 === 65120 or x0 === 65121 or x0 === 65128 or
              x0 === 65130 or
              x0 === 65131 or x0 === 65281 or x0 === 65282 or x0 === 65283 or x0 === 65285 or
              x0 === 65286 or
              x0 === 65287 or x0 === 65290 or x0 === 65292 or x0 === 65294 or x0 === 65295 or
              x0 === 65306 or
              x0 === 65307 or x0 === 65311 or x0 === 65312 or x0 === 65340 or x0 === 65377 or
              x0 === 65380 or
              x0 === 65381 or x0 === 65792 or x0 === 65793 or x0 === 65794 or x0 === 66463 or
              x0 === 66512 or
              x0 === 66927 or x0 === 67671 or x0 === 67871 or x0 === 67903 or x0 === 68176 or
              x0 === 68177 or
              x0 === 68178 or x0 === 68179 or x0 === 68180 or x0 === 68181 or x0 === 68182 or
              x0 === 68183 or
              x0 === 68184 or x0 === 68223 or x0 === 68336 or x0 === 68337 or x0 === 68338 or
              x0 === 68339 or
              x0 === 68340 or x0 === 68341 or x0 === 68342 or x0 === 68409 or x0 === 68410 or
              x0 === 68411 or
              x0 === 68412 or x0 === 68413 or x0 === 68414 or x0 === 68415 or x0 === 68505 or
              x0 === 68506 or
              x0 === 68507 or x0 === 68508 or x0 === 69461 or x0 === 69462 or x0 === 69463 or
              x0 === 69464 or
              x0 === 69465 or x0 === 69703 or x0 === 69704 or x0 === 69705 or x0 === 69706 or
              x0 === 69707 or
              x0 === 69708 or x0 === 69709 or x0 === 69819 or x0 === 69820 or x0 === 69822 or
              x0 === 69823 or
              x0 === 69824 or x0 === 69825 or x0 === 69952 or x0 === 69953 or x0 === 69954 or
              x0 === 69955 or
              x0 === 70004 or x0 === 70005 or x0 === 70085 or x0 === 70086 or x0 === 70087 or
              x0 === 70088 or
              x0 === 70093 or x0 === 70107 or x0 === 70109 or x0 === 70110 or x0 === 70111 or
              x0 === 70200 or
              x0 === 70201 or x0 === 70202 or x0 === 70203 or x0 === 70204 or x0 === 70205 or
              x0 === 70313 or
              x0 === 70731 or x0 === 70732 or x0 === 70733 or x0 === 70734 or x0 === 70735 or
              x0 === 70746 or
              x0 === 70747 or x0 === 70749 or x0 === 70854 or x0 === 71105 or x0 === 71106 or
              x0 === 71107 or
              x0 === 71108 or x0 === 71109 or x0 === 71110 or x0 === 71111 or x0 === 71112 or
              x0 === 71113 or
              x0 === 71114 or x0 === 71115 or x0 === 71116 or x0 === 71117 or x0 === 71118 or
              x0 === 71119 or
              x0 === 71120 or x0 === 71121 or x0 === 71122 or x0 === 71123 or x0 === 71124 or
              x0 === 71125 or
              x0 === 71126 or x0 === 71127 or x0 === 71233 or x0 === 71234 or x0 === 71235 or
              x0 === 71264 or
              x0 === 71265 or x0 === 71266 or x0 === 71267 or x0 === 71268 or x0 === 71269 or
              x0 === 71270 or
              x0 === 71271 or x0 === 71272 or x0 === 71273 or x0 === 71274 or x0 === 71275 or
              x0 === 71276 or
              x0 === 71484 or x0 === 71485 or x0 === 71486 or x0 === 71739 or x0 === 72004 or
              x0 === 72005 or
              x0 === 72006 or x0 === 72162 or x0 === 72255 or x0 === 72256 or x0 === 72257 or
              x0 === 72258 or
              x0 === 72259 or x0 === 72260 or x0 === 72261 or x0 === 72262 or x0 === 72346 or
              x0 === 72347 or
              x0 === 72348 or x0 === 72350 or x0 === 72351 or x0 === 72352 or x0 === 72353 or
              x0 === 72354 or
              x0 === 72769 or x0 === 72770 or x0 === 72771 or x0 === 72772 or x0 === 72773 or
              x0 === 72816 or
              x0 === 72817 or x0 === 73463 or x0 === 73464 or x0 === 73727 or x0 === 74864 or
              x0 === 74865 or
              x0 === 74866 or x0 === 74867 or x0 === 74868 or x0 === 92782 or x0 === 92783 or
              x0 === 92917 or
              x0 === 92983 or x0 === 92984 or x0 === 92985 or x0 === 92986 or x0 === 92987 or
              x0 === 92996 or
              x0 === 93847 or x0 === 93848 or x0 === 93849 or x0 === 93850 or x0 === 94178 or
              x0 === 113_823 or
              x0 === 121_479 or x0 === 121_480 or x0 === 121_481 or x0 === 121_482 or
              x0 === 121_483 or
              x0 === 125_278 or x0 === 125_279 do
    {:error,
     "did not expect utf8 codepoint in the range '\\n' to '\\r' or equal to '\\x85' or equal to ' ' or equal to ' ' or equal to ' ' or equal to ' ' or equal to ' ' or in the range ' ' to ' ' or equal to ' ' or equal to ' ' or equal to '　' or equal to ')' or equal to ']' or equal to '}' or equal to '༻' or equal to '༽' or equal to '᚜' or equal to '⁆' or equal to '⁾' or equal to '₎' or equal to '⌉' or equal to '⌋' or equal to '〉' or equal to '❩' or equal to '❫' or equal to '❭' or equal to '❯' or equal to '❱' or equal to '❳' or equal to '❵' or equal to '⟆' or equal to '⟧' or equal to '⟩' or equal to '⟫' or equal to '⟭' or equal to '⟯' or equal to '⦄' or equal to '⦆' or equal to '⦈' or equal to '⦊' or equal to '⦌' or equal to '⦎' or equal to '⦐' or equal to '⦒' or equal to '⦔' or equal to '⦖' or equal to '⦘' or equal to '⧙' or equal to '⧛' or equal to '⧽' or equal to '⸣' or equal to '⸥' or equal to '⸧' or equal to '⸩' or equal to '〉' or equal to '》' or equal to '」' or equal to '』' or equal to '】' or equal to '〕' or equal to '〗' or equal to '〙' or equal to '〛' or equal to '〞' or equal to '〟' or equal to '﴾' or equal to '︘' or equal to '︶' or equal to '︸' or equal to '︺' or equal to '︼' or equal to '︾' or equal to '﹀' or equal to '﹂' or equal to '﹄' or equal to '﹈' or equal to '﹚' or equal to '﹜' or equal to '﹞' or equal to '）' or equal to '］' or equal to '｝' or equal to '｠' or equal to '｣' or equal to '_' or equal to '‿' or equal to '⁀' or equal to '⁔' or equal to '︳' or equal to '︴' or equal to '﹍' or equal to '﹎' or equal to '﹏' or equal to '＿' or equal to '»' or equal to '’' or equal to '”' or equal to '›' or equal to '⸃' or equal to '⸅' or equal to '⸊' or equal to '⸍' or equal to '⸝' or equal to '⸡' or equal to '«' or equal to '‘' or equal to '‛' or equal to '“' or equal to '‟' or equal to '‹' or equal to '⸂' or equal to '⸄' or equal to '⸉' or equal to '⸌' or equal to '⸜' or equal to '⸠' or equal to '(' or equal to '[' or equal to '{' or equal to '༺' or equal to '༼' or equal to '᚛' or equal to '‚' or equal to '„' or equal to '⁅' or equal to '⁽' or equal to '₍' or equal to '⌈' or equal to '⌊' or equal to '〈' or equal to '❨' or equal to '❪' or equal to '❬' or equal to '❮' or equal to '❰' or equal to '❲' or equal to '❴' or equal to '⟅' or equal to '⟦' or equal to '⟨' or equal to '⟪' or equal to '⟬' or equal to '⟮' or equal to '⦃' or equal to '⦅' or equal to '⦇' or equal to '⦉' or equal to '⦋' or equal to '⦍' or equal to '⦏' or equal to '⦑' or equal to '⦓' or equal to '⦕' or equal to '⦗' or equal to '⧘' or equal to '⧚' or equal to '⧼' or equal to '⸢' or equal to '⸤' or equal to '⸦' or equal to '⸨' or equal to '⹂' or equal to '〈' or equal to '《' or equal to '「' or equal to '『' or equal to '【' or equal to '〔' or equal to '〖' or equal to '〘' or equal to '〚' or equal to '〝' or equal to '﴿' or equal to '︗' or equal to '︵' or equal to '︷' or equal to '︹' or equal to '︻' or equal to '︽' or equal to '︿' or equal to '﹁' or equal to '﹃' or equal to '﹇' or equal to '﹙' or equal to '﹛' or equal to '﹝' or equal to '（' or equal to '［' or equal to '｛' or equal to '｟' or equal to '｢' or equal to '!' or equal to '\"' or equal to '#' or equal to '%' or equal to '&' or equal to '\\'' or equal to '*' or equal to ',' or equal to '.' or equal to '/' or equal to ':' or equal to ';' or equal to '?' or equal to '@' or equal to '\\\\' or equal to '¡' or equal to '§' or equal to '¶' or equal to '·' or equal to '¿' or equal to ';' or equal to '·' or equal to '՚' or equal to '՛' or equal to '՜' or equal to '՝' or equal to '՞' or equal to '՟' or equal to '։' or equal to '׀' or equal to '׃' or equal to '׆' or equal to '׳' or equal to '״' or equal to '؉' or equal to '؊' or equal to '،' or equal to '؍' or equal to '؛' or equal to '؞' or equal to '؟' or equal to '٪' or equal to '٫' or equal to '٬' or equal to '٭' or equal to '۔' or equal to '܀' or equal to '܁' or equal to '܂' or equal to '܃' or equal to '܄' or equal to '܅' or equal to '܆' or equal to '܇' or equal to '܈' or equal to '܉' or equal to '܊' or equal to '܋' or equal to '܌' or equal to '܍' or equal to '߷' or equal to '߸' or equal to '߹' or equal to '࠰' or equal to '࠱' or equal to '࠲' or equal to '࠳' or equal to '࠴' or equal to '࠵' or equal to '࠶' or equal to '࠷' or equal to '࠸' or equal to '࠹' or equal to '࠺' or equal to '࠻' or equal to '࠼' or equal to '࠽' or equal to '࠾' or equal to '࡞' or equal to '।' or equal to '॥' or equal to '॰' or equal to '৽' or equal to '੶' or equal to '૰' or equal to '౷' or equal to '಄' or equal to '෴' or equal to '๏' or equal to '๚' or equal to '๛' or equal to '༄' or equal to '༅' or equal to '༆' or equal to '༇' or equal to '༈' or equal to '༉' or equal to '༊' or equal to '་' or equal to '༌' or equal to '།' or equal to '༎' or equal to '༏' or equal to '༐' or equal to '༑' or equal to '༒' or equal to '༔' or equal to '྅' or equal to '࿐' or equal to '࿑' or equal to '࿒' or equal to '࿓' or equal to '࿔' or equal to '࿙' or equal to '࿚' or equal to '၊' or equal to '။' or equal to '၌' or equal to '၍' or equal to '၎' or equal to '၏' or equal to '჻' or equal to '፠' or equal to '፡' or equal to '።' or equal to '፣' or equal to '፤' or equal to '፥' or equal to '፦' or equal to '፧' or equal to '፨' or equal to '᙮' or equal to '᛫' or equal to '᛬' or equal to '᛭' or equal to '᜵' or equal to '᜶' or equal to '។' or equal to '៕' or equal to '៖' or equal to '៘' or equal to '៙' or equal to '៚' or equal to '᠀' or equal to '᠁' or equal to '᠂' or equal to '᠃' or equal to '᠄' or equal to '᠅' or equal to '᠇' or equal to '᠈' or equal to '᠉' or equal to '᠊' or equal to '᥄' or equal to '᥅' or equal to '᨞' or equal to '᨟' or equal to '᪠' or equal to '᪡' or equal to '᪢' or equal to '᪣' or equal to '᪤' or equal to '᪥' or equal to '᪦' or equal to '᪨' or equal to '᪩' or equal to '᪪' or equal to '᪫' or equal to '᪬' or equal to '᪭' or equal to '᭚' or equal to '᭛' or equal to '᭜' or equal to '᭝' or equal to '᭞' or equal to '᭟' or equal to '᭠' or equal to '᯼' or equal to '᯽' or equal to '᯾' or equal to '᯿' or equal to '᰻' or equal to '᰼' or equal to '᰽' or equal to '᰾' or equal to '᰿' or equal to '᱾' or equal to '᱿' or equal to '᳀' or equal to '᳁' or equal to '᳂' or equal to '᳃' or equal to '᳄' or equal to '᳅' or equal to '᳆' or equal to '᳇' or equal to '᳓' or equal to '‖' or equal to '‗' or equal to '†' or equal to '‡' or equal to '•' or equal to '‣' or equal to '․' or equal to '‥' or equal to '…' or equal to '‧' or equal to '‰' or equal to '‱' or equal to '′' or equal to '″' or equal to '‴' or equal to '‵' or equal to '‶' or equal to '‷' or equal to '‸' or equal to '※' or equal to '‼' or equal to '‽' or equal to '‾' or equal to '⁁' or equal to '⁂' or equal to '⁃' or equal to '⁇' or equal to '⁈' or equal to '⁉' or equal to '⁊' or equal to '⁋' or equal to '⁌' or equal to '⁍' or equal to '⁎' or equal to '⁏' or equal to '⁐' or equal to '⁑' or equal to '⁓' or equal to '⁕' or equal to '⁖' or equal to '⁗' or equal to '⁘' or equal to '⁙' or equal to '⁚' or equal to '⁛' or equal to '⁜' or equal to '⁝' or equal to '⁞' or equal to '⳹' or equal to '⳺' or equal to '⳻' or equal to '⳼' or equal to '⳾' or equal to '⳿' or equal to '⵰' or equal to '⸀' or equal to '⸁' or equal to '⸆' or equal to '⸇' or equal to '⸈' or equal to '⸋' or equal to '⸎' or equal to '⸏' or equal to '⸐' or equal to '⸑' or equal to '⸒' or equal to '⸓' or equal to '⸔' or equal to '⸕' or equal to '⸖' or equal to '⸘' or equal to '⸙' or equal to '⸛' or equal to '⸞' or equal to '⸟' or equal to '⸪' or equal to '⸫' or equal to '⸬' or equal to '⸭' or equal to '⸮' or equal to '⸰' or equal to '⸱' or equal to '⸲' or equal to '⸳' or equal to '⸴' or equal to '⸵' or equal to '⸶' or equal to '⸷' or equal to '⸸' or equal to '⸹' or equal to '⸼' or equal to '⸽' or equal to '⸾' or equal to '⸿' or equal to '⹁' or equal to '⹃' or equal to '⹄' or equal to '⹅' or equal to '⹆' or equal to '⹇' or equal to '⹈' or equal to '⹉' or equal to '⹊' or equal to '⹋' or equal to '⹌' or equal to '⹍' or equal to '⹎' or equal to '⹏' or equal to '⹒' or equal to '、' or equal to '。' or equal to '〃' or equal to '〽' or equal to '・' or equal to '꓾' or equal to '꓿' or equal to '꘍' or equal to '꘎' or equal to '꘏' or equal to '꙳' or equal to '꙾' or equal to '꛲' or equal to '꛳' or equal to '꛴' or equal to '꛵' or equal to '꛶' or equal to '꛷' or equal to '꡴' or equal to '꡵' or equal to '꡶' or equal to '꡷' or equal to '꣎' or equal to '꣏' or equal to '꣸' or equal to '꣹' or equal to '꣺' or equal to '꣼' or equal to '꤮' or equal to '꤯' or equal to '꥟' or equal to '꧁' or equal to '꧂' or equal to '꧃' or equal to '꧄' or equal to '꧅' or equal to '꧆' or equal to '꧇' or equal to '꧈' or equal to '꧉' or equal to '꧊' or equal to '꧋' or equal to '꧌' or equal to '꧍' or equal to '꧞' or equal to '꧟' or equal to '꩜' or equal to '꩝' or equal to '꩞' or equal to '꩟' or equal to '꫞' or equal to '꫟' or equal to '꫰' or equal to '꫱' or equal to '꯫' or equal to '︐' or equal to '︑' or equal to '︒' or equal to '︓' or equal to '︔' or equal to '︕' or equal to '︖' or equal to '︙' or equal to '︰' or equal to '﹅' or equal to '﹆' or equal to '﹉' or equal to '﹊' or equal to '﹋' or equal to '﹌' or equal to '﹐' or equal to '﹑' or equal to '﹒' or equal to '﹔' or equal to '﹕' or equal to '﹖' or equal to '﹗' or equal to '﹟' or equal to '﹠' or equal to '﹡' or equal to '﹨' or equal to '﹪' or equal to '﹫' or equal to '！' or equal to '＂' or equal to '＃' or equal to '％' or equal to '＆' or equal to '＇' or equal to '＊' or equal to '，' or equal to '．' or equal to '／' or equal to '：' or equal to '；' or equal to '？' or equal to '＠' or equal to '＼' or equal to '｡' or equal to '､' or equal to '･' or equal to '𐄀' or equal to '𐄁' or equal to '𐄂' or equal to '𐎟' or equal to '𐏐' or equal to '𐕯' or equal to '𐡗' or equal to '𐤟' or equal to '𐤿' or equal to '𐩐' or equal to '𐩑' or equal to '𐩒' or equal to '𐩓' or equal to '𐩔' or equal to '𐩕' or equal to '𐩖' or equal to '𐩗' or equal to '𐩘' or equal to '𐩿' or equal to '𐫰' or equal to '𐫱' or equal to '𐫲' or equal to '𐫳' or equal to '𐫴' or equal to '𐫵' or equal to '𐫶' or equal to '𐬹' or equal to '𐬺' or equal to '𐬻' or equal to '𐬼' or equal to '𐬽' or equal to '𐬾' or equal to '𐬿' or equal to '𐮙' or equal to '𐮚' or equal to '𐮛' or equal to '𐮜' or equal to '𐽕' or equal to '𐽖' or equal to '𐽗' or equal to '𐽘' or equal to '𐽙' or equal to '𑁇' or equal to '𑁈' or equal to '𑁉' or equal to '𑁊' or equal to '𑁋' or equal to '𑁌' or equal to '𑁍' or equal to '𑂻' or equal to '𑂼' or equal to '𑂾' or equal to '𑂿' or equal to '𑃀' or equal to '𑃁' or equal to '𑅀' or equal to '𑅁' or equal to '𑅂' or equal to '𑅃' or equal to '𑅴' or equal to '𑅵' or equal to '𑇅' or equal to '𑇆' or equal to '𑇇' or equal to '𑇈' or equal to '𑇍' or equal to '𑇛' or equal to '𑇝' or equal to '𑇞' or equal to '𑇟' or equal to '𑈸' or equal to '𑈹' or equal to '𑈺' or equal to '𑈻' or equal to '𑈼' or equal to '𑈽' or equal to '𑊩' or equal to '𑑋' or equal to '𑑌' or equal to '𑑍' or equal to '𑑎' or equal to '𑑏' or equal to '𑑚' or equal to '𑑛' or equal to '𑑝' or equal to '𑓆' or equal to '𑗁' or equal to '𑗂' or equal to '𑗃' or equal to '𑗄' or equal to '𑗅' or equal to '𑗆' or equal to '𑗇' or equal to '𑗈' or equal to '𑗉' or equal to '𑗊' or equal to '𑗋' or equal to '𑗌' or equal to '𑗍' or equal to '𑗎' or equal to '𑗏' or equal to '𑗐' or equal to '𑗑' or equal to '𑗒' or equal to '𑗓' or equal to '𑗔' or equal to '𑗕' or equal to '𑗖' or equal to '𑗗' or equal to '𑙁' or equal to '𑙂' or equal to '𑙃' or equal to '𑙠' or equal to '𑙡' or equal to '𑙢' or equal to '𑙣' or equal to '𑙤' or equal to '𑙥' or equal to '𑙦' or equal to '𑙧' or equal to '𑙨' or equal to '𑙩' or equal to '𑙪' or equal to '𑙫' or equal to '𑙬' or equal to '𑜼' or equal to '𑜽' or equal to '𑜾' or equal to '𑠻' or equal to '𑥄' or equal to '𑥅' or equal to '𑥆' or equal to '𑧢' or equal to '𑨿' or equal to '𑩀' or equal to '𑩁' or equal to '𑩂' or equal to '𑩃' or equal to '𑩄' or equal to '𑩅' or equal to '𑩆' or equal to '𑪚' or equal to '𑪛' or equal to '𑪜' or equal to '𑪞' or equal to '𑪟' or equal to '𑪠' or equal to '𑪡' or equal to '𑪢' or equal to '𑱁' or equal to '𑱂' or equal to '𑱃' or equal to '𑱄' or equal to '𑱅' or equal to '𑱰' or equal to '𑱱' or equal to '𑻷' or equal to '𑻸' or equal to '𑿿' or equal to '𒑰' or equal to '𒑱' or equal to '𒑲' or equal to '𒑳' or equal to '𒑴' or equal to '𖩮' or equal to '𖩯' or equal to '𖫵' or equal to '𖬷' or equal to '𖬸' or equal to '𖬹' or equal to '𖬺' or equal to '𖬻' or equal to '𖭄' or equal to '𖺗' or equal to '𖺘' or equal to '𖺙' or equal to '𖺚' or equal to '𖿢' or equal to '𛲟' or equal to '𝪇' or equal to '𝪈' or equal to '𝪉' or equal to '𝪊' or equal to '𝪋' or equal to '𞥞' or equal to '𞥟'",
     rest, context, line, offset}
  end

  defp component_word_allowed_char__0(rest, acc, stack, context, line, offset) do
    component_word_allowed_char__1(rest, acc, stack, context, line, offset)
  end

  defp component_word_allowed_char__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end
end
