defmodule Recipex.Recipe do
  @moduledoc false

  alias Recipex.Cookware
  alias Recipex.Ingredient
  alias Recipex.Timer

  defstruct metadata: %{}, cookware: [], ingredients: [], steps: [], timers: []

  @type t :: %__MODULE__{
          metadata: %{binary => binary},
          cookware: [Cookware.t()],
          ingredients: [Ingredient.t()],
          steps: [[Cookware.t() | Ingredient.t() | Text.t() | Timer.t()] | binary],
          timers: [Timer.t()]
        }

  @spec add_cookware(t(), Cookware.t()) :: t()
  def add_cookware(%__MODULE__{cookware: lst} = recipe, %Cookware{} = cookware) do
    %{recipe | cookware: lst ++ [cookware]}
  end

  @spec add_ingredient(t(), Ingredient.t()) :: t()
  def add_ingredient(%__MODULE__{ingredients: lst} = recipe, %Ingredient{} = ingredient) do
    %{recipe | ingredients: lst ++ [ingredient]}
  end

  @spec add_metadata(t(), binary, term) :: t()
  def add_metadata(%__MODULE__{metadata: metadata} = recipe, key, value) do
    %{recipe | metadata: Map.put(metadata, key, value)}
  end

  @spec add_step(t(), [Cookware.t() | Ingredient.t() | Text.t() | Timer.t()]) :: t()
  def add_step(%__MODULE__{steps: steps} = recipe, step) do
    %{recipe | steps: steps ++ [step]}
  end

  @spec add_timer(t(), Timer.t()) :: t()
  def add_timer(%__MODULE__{timers: lst} = recipe, %Timer{} = timer) do
    %{recipe | timers: lst ++ [timer]}
  end

  @spec reduce_steps(t()) :: t()
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
