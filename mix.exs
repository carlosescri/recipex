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
      aliases: aliases(Mix.env()),
      deps: deps(),
      package: package(),
      dialyzer: [plt_add_apps: [:mix]]
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
      {:nimble_parsec, "~> 1.3", only: [:dev, :test]},
      {:unicode, "~> 1.16", only: [:dev, :test]},
      {:unicode_set, "~> 1.3", only: [:dev, :test]},
      {:httpoison, "~> 2.0", only: [:dev, :test]},
      {:yaml_elixir, "~> 2.9", only: [:dev, :test]},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false}
    ]
  end

  defp aliases(env) when env in [:dev, :test] do
    [
      consistency: [
        "format",
        "dialyzer --ignore-exit-status",
        "credo --config-name default"
      ],
      "recipex.build": [
        "nimble_parsec.compile lib/recipex/parser.ex.exs"
      ]
    ]
  end

  defp aliases(_), do: []
end
