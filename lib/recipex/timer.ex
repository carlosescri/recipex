defmodule Recipex.Timer do
  @moduledoc false

  @enforce_keys [:quantity, :unit]
  defstruct [:name] ++ @enforce_keys
end
