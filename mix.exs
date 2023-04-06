defmodule Recipex.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/carlosescri/recipex"

  def project do
    [
      app: :recipex,
      version: @version,
      elixir: "~> 1.14",
      name: "Recipex",
      description: "",
      aliases: [],
      deps: deps(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Carlos Escribano"],
      links: %{"Github" => @url}
    }
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_parsec, "~> 1.3"}
    ]
  end
end
