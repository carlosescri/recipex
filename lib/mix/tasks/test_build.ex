defmodule Mix.Tasks.Test.Build do
  @moduledoc """
  Build tests file from previously downloaded CookLang specs.

  Run `mix test.update` to download the latest version of the tests.
  """
  @shortdoc "Build tests file from previously downloaded CookLang specs."

  use Mix.Task

  def run(_) do
    Application.ensure_all_started(:yaml_elixir)

    source_file = Path.join([File.cwd!(), "priv", "canonical.yaml"])
    target_file = Path.join([File.cwd!(), "test", "canonical_test.exs"])

    tests =
      source_file
      |> YamlElixir.read_from_file!()
      |> Map.fetch!("tests")
      |> Enum.map(&build_test/1)

    File.write!(
      target_file,
      build_file(tests),
      [:write]
    )

    IO.puts("Canonical tests were built successfully!")
  rescue
    error in RuntimeError ->
      IO.puts("Error building canonical tests: #{error.message}")
  end

  defp build_test({name, %{"source" => source, "result" => result}}) do
    %{
      description: build_test_description(name),
      source: build_test_source(source),
      result: result
    }
  end

  defp build_file(tests) do
    template = """
    defmodule CanonicalTest do
      use ExUnit.Case

      defp update_steps_components(map, update_fun) do
        Map.update(map, "steps", [], fn steps ->
          Enum.map(steps, fn components_list ->
            Enum.map(components_list, fn component ->
              update_fun.(component)
            end)
          end)
        end)
      end

      defp parse(text) do
        text
        |> Recipex.parse()
        |> Map.from_struct()
        |> stringify_keys()
        |> Map.take(["steps", "metadata"])
        |> update_steps_components(fn component ->
          component
          |> Map.from_struct()
          |> stringify_keys()
        end)
      end

      defp patch_result(result) do
        update_steps_components(result, fn component ->
          component
          |> patch_quantity()
          |> patch_units()
          |> Map.delete("type")
        end)
      end

      defp stringify_keys(map),
        do: Map.new(map, &{Atom.to_string(elem(&1, 0)), elem(&1, 1)})

      defp patch_quantity(%{"quantity" => "some"} = component),
        do: Map.put(component, "quantity", nil)

      defp patch_quantity(component),
        do: component

      defp patch_units(%{"units" => ""} = component),
        do: Map.put(component, "units", nil)

      defp patch_units(component),
        do: component
      <%= for test <- @tests do %>
      test "<%= test.description %>" do
        parsed = parse("<%= test.source %>")
        expected = patch_result(<%= inspect(test.result) %>)
        assert parsed == expected
      end
      <% end %>
    end
    """

    EEx.eval_string(template, assigns: [tests: tests])
  end

  defp build_test_description(camelcase_name) do
    camelcase_name
    |> Macro.underscore()
    |> String.replace("test_", "")
    |> String.replace("_", " ")
  end

  defp build_test_source(source) do
    String.replace(source, "\n", "\\n")
  end
end
