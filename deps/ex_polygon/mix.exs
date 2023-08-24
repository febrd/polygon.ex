defmodule ExPolygon.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_polygon,
      version: "0.0.4",
      elixir: "~> 1.8",
      package: package(),
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.0"},
      {:mapail, "~> 1.0.2"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:exvcr, "~> 0.10.2", only: [:dev, :test]},
      {:mock, "~> 0.3.3", only: :test},
      {:mix_test_watch, "~> 0.9", only: :dev, runtime: false},
      {:ex_unit_notifier, "~> 0.1", only: :test},
      {:dialyxir, "~> 1.0.0-rc.4", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Polygon.io API Client for Elixir"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-capital/ex_polygon"}
    }
  end
end
