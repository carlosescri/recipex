defmodule Recipex.Recipe do
  @moduledoc false

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Timer

  defstruct metadata: %{}, cookware: [], ingredients: [], steps: [], timers: []

  def register_cookware(%__MODULE{cookware: lst} = recipe, %Cookware{} = cookware) do
    %{recipe | cookware: lst ++ [cookware]}
  end

  def register_ingredient(%__MODULE{ingredients: lst} = recipe, %Ingredient{} = ingredient) do
    %{recipe | ingredients: lst ++ [ingredient]}
  end

  def register_metadata(%__MODULE{metadata: metadata} = recipe, key, value) do
    %{recipe | metadata: Map.put(metadata, key, value)}
  end

  def register_step(%__MODULE{steps: steps} = recipe, step) do
    %{recipe | steps: steps ++ [step]}
  end

  def register_timer(%__MODULE{timers: lst} = recipe, %Timer{} = timer) do
    %{recipe | timers: lst ++ [timer]}
  end
end
