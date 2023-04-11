defmodule Recipex.Recipe do
  @moduledoc false

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Timer

  defstruct metadata: %{}, cookware: [], ingredients: [], steps: [], timers: []

  def add_cookware(%__MODULE__{cookware: lst} = recipe, %Cookware{} = cookware) do
    %{recipe | cookware: lst ++ [cookware]}
  end

  def add_ingredient(%__MODULE__{ingredients: lst} = recipe, %Ingredient{} = ingredient) do
    %{recipe | ingredients: lst ++ [ingredient]}
  end

  def add_metadata(%__MODULE__{metadata: metadata} = recipe, key, value) do
    %{recipe | metadata: Map.put(metadata, key, value)}
  end

  def add_step(%__MODULE__{steps: steps} = recipe, step) do
    %{recipe | steps: steps ++ [step]}
  end

  def add_timer(%__MODULE__{timers: lst} = recipe, %Timer{} = timer) do
    %{recipe | timers: lst ++ [timer]}
  end

  def reduce_steps(%__MODULE__{steps: steps} = recipe) do
    steps =
      Enum.map(steps, fn step ->
        step
        |> Stream.map(&to_string/1)
        |> Enum.join()
      end)

    %{recipe | steps: steps}
  end
end
