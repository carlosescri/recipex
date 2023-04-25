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

  defp compatible(recipe) do
    recipe
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
    {:ok, parsed} = Recipex.parse("@chilli cut into pieces and @garlic\n")

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

    assert compatible(parsed) == expected
  end

  test "fractions with spaces" do
    {:ok, parsed} = Recipex.parse("@milk{1 / 2 %cup}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "milk", "quantity" => 0.5, "type" => "ingredient", "units" => "cup"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "fractions like" do
    {:ok, parsed} = Recipex.parse("@milk{01/2%cup}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "milk", "quantity" => "01/2", "type" => "ingredient", "units" => "cup"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "multi line directions" do
    {:ok, parsed} = Recipex.parse("Add a bit of chilli\n\nAdd a bit of hummus\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"type" => "text", "value" => "Add a bit of chilli"}],
          [%{"type" => "text", "value" => "Add a bit of hummus"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "timer with name" do
    {:ok, parsed} = Recipex.parse("Fry for ~potato{42%minutes}\n")

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

    assert compatible(parsed) == expected
  end

  test "comments" do
    {:ok, parsed} = Recipex.parse("-- testing comments\n")
    expected = patch_result(%{"metadata" => %{}, "steps" => []})
    assert compatible(parsed) == expected
  end

  test "servings" do
    {:ok, parsed} = Recipex.parse(">> servings: 1|2|3\n")
    expected = patch_result(%{"metadata" => %{"servings" => "1|2|3"}, "steps" => []})
    assert compatible(parsed) == expected
  end

  test "direction with ingrident" do
    {:ok, parsed} = Recipex.parse("Add @chilli{3%items}, @ginger{10%g} and @milk{1%l}.\n")

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

    assert compatible(parsed) == expected
  end

  test "fractions" do
    {:ok, parsed} = Recipex.parse("@milk{1/2%cup}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "milk", "quantity" => 0.5, "type" => "ingredient", "units" => "cup"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "metadata multiword key" do
    {:ok, parsed} = Recipex.parse(">> cooking time: 30 mins\n")
    expected = patch_result(%{"metadata" => %{"cooking time" => "30 mins"}, "steps" => []})
    assert compatible(parsed) == expected
  end

  test "equipment quantity multiple words" do
    {:ok, parsed} = Recipex.parse("#frying pan{two small}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"name" => "frying pan", "quantity" => "two small", "type" => "cookware"}]]
      })

    assert compatible(parsed) == expected
  end

  test "ingrident implicit units" do
    {:ok, parsed} = Recipex.parse("@chilli{3}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => ""}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "metadata" do
    {:ok, parsed} = Recipex.parse(">> sourced: babooshka\n")
    expected = patch_result(%{"metadata" => %{"sourced" => "babooshka"}, "steps" => []})
    assert compatible(parsed) == expected
  end

  test "timer fractional" do
    {:ok, parsed} = Recipex.parse("Fry for ~{1/2%hour}\n")

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

    assert compatible(parsed) == expected
  end

  test "ingrident explicit units" do
    {:ok, parsed} = Recipex.parse("@chilli{3%items}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => "items"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "quantity as text" do
    {:ok, parsed} = Recipex.parse("@thyme{few%springs}\n")

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

    assert compatible(parsed) == expected
  end

  test "equipment multiple words with spaces" do
    {:ok, parsed} = Recipex.parse("Fry in #frying pan{ }\n")

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

    assert compatible(parsed) == expected
  end

  test "ingredient with emoji" do
    {:ok, parsed} = Recipex.parse("Add some @🧂\n")

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

    assert compatible(parsed) == expected
  end

  test "quantity digital string" do
    {:ok, parsed} = Recipex.parse("@water{7 k }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "water", "quantity" => "7 k", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "metadata multiword key with spaces" do
    {:ok, parsed} = Recipex.parse(">>cooking time    :30 mins\n")
    expected = patch_result(%{"metadata" => %{"cooking time" => "30 mins"}, "steps" => []})
    assert compatible(parsed) == expected
  end

  test "equipment multiple words" do
    {:ok, parsed} = Recipex.parse("Fry in #frying pan{}\n")

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

    assert compatible(parsed) == expected
  end

  test "equipment one word" do
    {:ok, parsed} = Recipex.parse("Simmer in #pan for some time\n")

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

    assert compatible(parsed) == expected
  end

  test "basic direction" do
    {:ok, parsed} = Recipex.parse("Add a bit of chilli\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Add a bit of chilli"}]]
      })

    assert compatible(parsed) == expected
  end

  test "comments after ingredients" do
    {:ok, parsed} = Recipex.parse("@thyme{2%springs} -- testing comments\nand some text\n")

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

    assert compatible(parsed) == expected
  end

  test "equipment quantity one word" do
    {:ok, parsed} = Recipex.parse("#frying pan{three}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"name" => "frying pan", "quantity" => "three", "type" => "cookware"}]]
      })

    assert compatible(parsed) == expected
  end

  test "directions with numbers" do
    {:ok, parsed} = Recipex.parse("Heat 5L of water\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Heat 5L of water"}]]
      })

    assert compatible(parsed) == expected
  end

  test "comments with ingredients" do
    {:ok, parsed} = Recipex.parse("-- testing comments\n@thyme{2%springs}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "thyme", "quantity" => 2, "type" => "ingredient", "units" => "springs"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "ingrident no units not only string" do
    {:ok, parsed} = Recipex.parse("@5peppers\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "5peppers", "quantity" => "some", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "ingrident no units" do
    {:ok, parsed} = Recipex.parse("@chilli\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => "some", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "equipment quantity" do
    {:ok, parsed} = Recipex.parse("#frying pan{2}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"name" => "frying pan", "quantity" => 2, "type" => "cookware"}]]
      })

    assert compatible(parsed) == expected
  end

  test "directions with degrees" do
    {:ok, parsed} = Recipex.parse("Heat oven up to 200°C\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Heat oven up to 200°C"}]]
      })

    assert compatible(parsed) == expected
  end

  test "ingrident with numbers" do
    {:ok, parsed} = Recipex.parse("@tipo 00 flour{250%g}\n")

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

    assert compatible(parsed) == expected
  end

  test "metadata break" do
    {:ok, parsed} = Recipex.parse("hello >> sourced: babooshka\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "hello >> sourced: babooshka"}]]
      })

    assert compatible(parsed) == expected
  end

  test "multi word ingrident no amount" do
    {:ok, parsed} = Recipex.parse("@hot chilli{}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "hot chilli", "quantity" => "some", "type" => "ingredient", "units" => ""}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "slash in text" do
    {:ok, parsed} = Recipex.parse("Preheat the oven to 200℃/Fan 180°C.\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "Preheat the oven to 200℃/Fan 180°C."}]]
      })

    assert compatible(parsed) == expected
  end

  test "multi word ingrident" do
    {:ok, parsed} = Recipex.parse("@hot chilli{3}\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "hot chilli", "quantity" => 3, "type" => "ingredient", "units" => ""}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "ingrident explicit units with spaces" do
    {:ok, parsed} = Recipex.parse("@chilli{ 3 % items }\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [
          [%{"name" => "chilli", "quantity" => 3, "type" => "ingredient", "units" => "items"}]
        ]
      })

    assert compatible(parsed) == expected
  end

  test "multiple lines" do
    {:ok, parsed} = Recipex.parse(">> Prep Time: 15 minutes\n>> Cook Time: 30 minutes\n")

    expected =
      patch_result(%{
        "metadata" => %{"Cook Time" => "30 minutes", "Prep Time" => "15 minutes"},
        "steps" => []
      })

    assert compatible(parsed) == expected
  end

  test "fractions in directions" do
    {:ok, parsed} = Recipex.parse("knife cut about every 1/2 inches\n")

    expected =
      patch_result(%{
        "metadata" => %{},
        "steps" => [[%{"type" => "text", "value" => "knife cut about every 1/2 inches"}]]
      })

    assert compatible(parsed) == expected
  end

  test "ingredient multiple words with leading number" do
    {:ok, parsed} = Recipex.parse("Top with @1000 island dressing{ }\n")

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

    assert compatible(parsed) == expected
  end

  test "equipment multiple words with leading number" do
    {:ok, parsed} = Recipex.parse("Fry in #7-inch nonstick frying pan{ }\n")

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

    assert compatible(parsed) == expected
  end

  test "timer decimal" do
    {:ok, parsed} = Recipex.parse("Fry for ~{1.5%minutes}\n")

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

    assert compatible(parsed) == expected
  end

  test "ingrident without stopper" do
    {:ok, parsed} = Recipex.parse("@chilli cut into pieces\n")

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

    assert compatible(parsed) == expected
  end

  test "timer integer" do
    {:ok, parsed} = Recipex.parse("Fry for ~{10%minutes}\n")

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

    assert compatible(parsed) == expected
  end
end
