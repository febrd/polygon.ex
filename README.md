# PolygonApi

Polygon.io API Client for Elixir

## Specification
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
config :polygon_api, endpoint: "https://api.polygon.io"
```

## Usage

Pass the api key along to any API calls you make

Example : SYMBOL = AAPL

```elixir
iex(1)> PolygonApi.Prod.Aggregate.query("SYMBOL", 1, "minute", "2023-01-01", "2023-08-01", "YOUR_API_KEY") 
iex(2)> PolygonApi.Prod.Exchange.query("YOUR_API_KEY")
iex(3)> PolygonApi.Prod.Locales.query("YOUR_API_KEY") 
iex(4)> PolygonApi.Prod.Markets.query("YOUR_API_KEY") 
iex(5)> PolygonApi.Prod.Tickers.query(                                                                             
...(5)>   %{
...(5)>     "locale" => "us",
...(5)>     "page" => 1,
...(5)>     "perpage" => 50
...(5)>   },
...(5)>   "YOUR_API_KEY"
...(5)> )
iex(6)> PolygonApi.Prod.Symbol.company_details("SYMBOL", "YOUR_API_KEY")
iex(7)> PolygonApi.Prod.Symbol.dividends("SYMBOL", "YOUR_API_KEY")
iex(8)> PolygonApi.Prod.Symbol.financials("SYMBOL", "YOUR_API_KEY")
iex(9)> PolygonApi.Prod.Tipe.query("YOUR_API_KEY")               
```
