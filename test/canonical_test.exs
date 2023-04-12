defmodule CanonicalTest do
  use ExUnit.Case

  defp update_steps_components(map, update_fun) do
    map
    |> Map.get("steps", [])
    |> Enum.map(fn components_list ->
      Enum.map(components_list, &update_fun.(&1))
    end)
    |> then(&Map.put(map, "steps", &1))
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

  test "mutiple ingridents without stopper" do
    parsed = parse("@chilli cut into pieces and @garlic\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"name" => "chilli", "quantity" => "some", "type" => "ingredient", "units" => ""},
            %{"type" => "text", "value" => " cut into pieces and "},
            %{"name" => "garlic", "quantity" => "some", "type" => "ingredient", "units" => ""}
          ]
        ]
      })

    assert parsed == expected
  end

  test "fractions with spaces" do
    parsed = parse("@milk{1 / 2 %cup}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "milk", "quantity" => 0.5, "type" => "ingredient", "units" => "cup"}]
        ]
      })

    assert parsed == expected
  end

  test "fractions like" do
    parsed = parse("@milk{01/2%cup}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "milk", "quantity" => "01/2", "type" => "ingredient", "units" => "cup"}]
        ]
      })

    assert parsed == expected
  end

  test "multi line directions" do
    parsed = parse("Add a bit of chilli\n\nAdd a bit of hummus\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"type" => "text", "value" => "Add a bit of chilli"}],
          [%{"type" => "text", "value" => "Add a bit of hummus"}]
        ]
      })

    assert parsed == expected
  end

  test "timer with name" do
    parsed = parse("Fry for ~potato{42%minutes}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry for "},
            %{"name" => "potato", "quantity" => 42, "type" => "timer", "units" => "minutes"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "comments" do
    parsed = parse("-- testing comments\n")
    expected = patch_result(%{"metadata" => %{}, "steps" => []})
    assert parsed == expected
  end

  test "servings" do
    parsed = parse(">> servings: 1|2|3\n")
    expected = patch_result(%{"metadata" => %{"servings" => "1|2|3"}, "steps" => []})
    assert parsed == expected
  end

  test "direction with ingrident" do
    parsed = parse("Add @chilli{3%items}, @ginger{10%g} and @milk{1%l}.\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Add "},
            %{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => "items"},
            %{"type" => "text", "value" => ", "},
            %{"name" => "ginger", "quantity" => 10, "type" => "ingredient", "units" => "g"},
            %{"type" => "text", "value" => " and "},
            %{"name" => "milk", "quantity" => 1, "type" => "ingredient", "units" => "l"},
            %{"type" => "text", "value" => "."}
          ]
        ]
      })

    assert parsed == expected
  end

  test "fractions" do
    parsed = parse("@milk{1/2%cup}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "milk", "quantity" => 0.5, "type" => "ingredient", "units" => "cup"}]
        ]
      })

    assert parsed == expected
  end

  test "metadata multiword key" do
    parsed = parse(">> cooking time: 30 mins\n")
    expected = patch_result(%{"metadata" => %{"cooking time" => "30 mins"}, "steps" => []})
    assert parsed == expected
  end

  test "equipment quantity multiple words" do
    parsed = parse("#frying pan{two small}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"name" => "frying pan", "quantity" => "two small", "type" => "cookware"}]]
      })

    assert parsed == expected
  end

  test "ingrident implicit units" do
    parsed = parse("@chilli{3}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => ""}]
        ]
      })

    assert parsed == expected
  end

  test "metadata" do
    parsed = parse(">> sourced: babooshka\n")
    expected = patch_result(%{"metadata" => %{"sourced" => "babooshka"}, "steps" => []})
    assert parsed == expected
  end

  test "timer fractional" do
    parsed = parse("Fry for ~{1/2%hour}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry for "},
            %{"name" => "", "quantity" => 0.5, "type" => "timer", "units" => "hour"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "ingrident explicit units" do
    parsed = parse("@chilli{3%items}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => "items"}]
        ]
      })

    assert parsed == expected
  end

  test "quantity as text" do
    parsed = parse("@thyme{few%springs}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{
              "name" => "thyme",
              "quantity" => "few",
              "type" => "ingredient",
              "units" => "springs"
            }
          ]
        ]
      })

    assert parsed == expected
  end

  test "equipment multiple words with spaces" do
    parsed = parse("Fry in #frying pan{ }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry in "},
            %{"name" => "frying pan", "quantity" => 1, "type" => "cookware"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "ingredient with emoji" do
    parsed = parse("Add some @🧂\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Add some "},
            %{"name" => "🧂", "quantity" => "some", "type" => "ingredient", "units" => ""}
          ]
        ]
      })

    assert parsed == expected
  end

  test "quantity digital string" do
    parsed = parse("@water{7 k }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "water", "quantity" => "7 k", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert parsed == expected
  end

  test "metadata multiword key with spaces" do
    parsed = parse(">>cooking time    :30 mins\n")
    expected = patch_result(%{"metadata" => %{"cooking time" => "30 mins"}, "steps" => []})
    assert parsed == expected
  end

  test "equipment multiple words" do
    parsed = parse("Fry in #frying pan{}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry in "},
            %{"name" => "frying pan", "quantity" => 1, "type" => "cookware"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "equipment one word" do
    parsed = parse("Simmer in #pan for some time\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Simmer in "},
            %{"name" => "pan", "quantity" => 1, "type" => "cookware"},
            %{"type" => "text", "value" => " for some time"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "basic direction" do
    parsed = parse("Add a bit of chilli\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Add a bit of chilli"}]]
      })

    assert parsed == expected
  end

  test "comments after ingredients" do
    parsed = parse("@thyme{2%springs} -- testing comments\nand some text\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"name" => "thyme", "quantity" => 2, "type" => "ingredient", "units" => "springs"},
            %{"type" => "text", "value" => " "}
          ],
          [%{"type" => "text", "value" => "and some text"}]
        ]
      })

    assert parsed == expected
  end

  test "equipment quantity one word" do
    parsed = parse("#frying pan{three}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"name" => "frying pan", "quantity" => "three", "type" => "cookware"}]]
      })

    assert parsed == expected
  end

  test "directions with numbers" do
    parsed = parse("Heat 5L of water\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Heat 5L of water"}]]
      })

    assert parsed == expected
  end

  test "comments with ingredients" do
    parsed = parse("-- testing comments\n@thyme{2%springs}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "thyme", "quantity" => 2, "type" => "ingredient", "units" => "springs"}]
        ]
      })

    assert parsed == expected
  end

  test "ingrident no units not only string" do
    parsed = parse("@5peppers\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "5peppers", "quantity" => "some", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert parsed == expected
  end

  test "ingrident no units" do
    parsed = parse("@chilli\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => "some", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert parsed == expected
  end

  test "equipment quantity" do
    parsed = parse("#frying pan{2}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"name" => "frying pan", "quantity" => 2, "type" => "cookware"}]]
      })

    assert parsed == expected
  end

  test "directions with degrees" do
    parsed = parse("Heat oven up to 200°C\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Heat oven up to 200°C"}]]
      })

    assert parsed == expected
  end

  test "ingrident with numbers" do
    parsed = parse("@tipo 00 flour{250%g}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{
              "name" => "tipo 00 flour",
              "quantity" => 250,
              "type" => "ingredient",
              "units" => "g"
            }
          ]
        ]
      })

    assert parsed == expected
  end

  test "metadata break" do
    parsed = parse("hello >> sourced: babooshka\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "hello >> sourced: babooshka"}]]
      })

    assert parsed == expected
  end

  test "multi word ingrident no amount" do
    parsed = parse("@hot chilli{}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "hot chilli", "quantity" => "some", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert parsed == expected
  end

  test "slash in text" do
    parsed = parse("Preheat the oven to 200℃/Fan 180°C.\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Preheat the oven to 200℃/Fan 180°C."}]]
      })

    assert parsed == expected
  end

  test "multi word ingrident" do
    parsed = parse("@hot chilli{3}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "hot chilli", "quantity" => 3, "type" => "ingredient", "units" => ""}]
        ]
      })

    assert parsed == expected
  end

  test "ingrident explicit units with spaces" do
    parsed = parse("@chilli{ 3 % items }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => "items"}]
        ]
      })

    assert parsed == expected
  end

  test "multiple lines" do
    parsed = parse(">> Prep Time: 15 minutes\n>> Cook Time: 30 minutes\n")

    expected =
      patch_result(%{
        "metadata" => %{"Cook Time" => "30 minutes", "Prep Time" => "15 minutes"},
        "steps" => []
      })

    assert parsed == expected
  end

  test "fractions in directions" do
    parsed = parse("knife cut about every 1/2 inches\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "knife cut about every 1/2 inches"}]]
      })

    assert parsed == expected
  end

  test "ingredient multiple words with leading number" do
    parsed = parse("Top with @1000 island dressing{ }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Top with "},
            %{
              "name" => "1000 island dressing",
              "quantity" => "some",
              "type" => "ingredient",
              "units" => ""
            }
          ]
        ]
      })

    assert parsed == expected
  end

  test "equipment multiple words with leading number" do
    parsed = parse("Fry in #7-inch nonstick frying pan{ }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry in "},
            %{"name" => "7-inch nonstick frying pan", "quantity" => 1, "type" => "cookware"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "timer decimal" do
    parsed = parse("Fry for ~{1.5%minutes}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry for "},
            %{"name" => "", "quantity" => 1.5, "type" => "timer", "units" => "minutes"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "ingrident without stopper" do
    parsed = parse("@chilli cut into pieces\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"name" => "chilli", "quantity" => "some", "type" => "ingredient", "units" => ""},
            %{"type" => "text", "value" => " cut into pieces"}
          ]
        ]
      })

    assert parsed == expected
  end

  test "timer integer" do
    parsed = parse("Fry for ~{10%minutes}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [
            %{"type" => "text", "value" => "Fry for "},
            %{"name" => "", "quantity" => 10, "type" => "timer", "units" => "minutes"}
          ]
        ]
      })

    assert parsed == expected
  end
end
