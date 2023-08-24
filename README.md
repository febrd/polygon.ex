# PolygonApi

Polygon.io API Client for Elixir

## Installation
Specification
```elixir
 def project do
    [
     ...
      elixir: "~> 1.15"
     ...
    ]
  end
```
List the Hex package in your application dependencies.

```elixir
def deps do
  [
    {:phoenix, "~> 1.7.7"},
    {:ex_polygon, "~> 0.0.4"}
  ]
end
```

Run mix deps.get to install.

## Configuration

Add the following configuration variables in your `config/config.exs` file:

```elixir
use Mix.Config

config :polygon_api, endpoint: "https://api.polygon.io"
```

## Usage

Pass the api key along to any API calls you make

```elixir
iex(1)> PolygonApi.Prod.Aggregate.query("AAPL", 1, "minute", "2023-01-01", "2023-08-01", "YOUR_API_KEY") 
iex(2)> PolygonApi.Prod.Exchange.query("YOUR_API_KEY")
iex(3)> PolygonApi.Prod.Locales.query("YOUR_API_KEY") 
iex(4)> PolygonApi.Prod.Markets.query("YOUR_API_KEY") 

```
