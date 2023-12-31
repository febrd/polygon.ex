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


## Configuration

Add the following configuration variables in your `config/config.exs` file:

```elixir
config :polygon_api, endpoint: "https://api.polygon.io"
```

Run

```shell
• mix deps.get
• mix compile
• iex -S mix run / iex -S mix phx.server
```


## Usage


Example Params : 
```
- SYMBOL = AAPL
- INT_TIME = 1 (Max 240 - Recommended)
- TIME = minute / hour
- DATE_FROM = 2023-01-01
- DATE_TO = 2023-08-01
- API_KEY = _ZtJr4WeQpSKn******pHLQQN7_1jgR
```

Interactive Elixir (1.15.2) :
```shell
iex(1)> PolygonApi.Prod.Aggregate.query("SYMBOL", "INT_TIME", "TIME", "DATE_FROM", "DATE_TO", "YOUR_API_KEY") 
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














