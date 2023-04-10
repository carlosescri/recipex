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
    [
      extra_applications: extra_applications(Mix.env())
    ]
  end

  defp extra_applications(env) when env in [:dev, :test], do: [:eex]

  defp extra_applications(_), do: []

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
      {:nimble_parsec, "~> 1.3"},
      {:httpoison, "~> 2.0", only: [:dev, :test]},
      {:yaml_elixir, "~> 2.9", only: [:dev, :test]}
    ]
  end
end
