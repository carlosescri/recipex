defmodule RecipexTest do
  use ExUnit.Case
  doctest Recipex

  test "greets the world" do
    assert Recipex.hello() == :world
  end
end
