defmodule PolygonApi.Tickers do
  @type t :: %PolygonApi.Tickers{}

  defstruct ~w(count page per_page status tickers)a
end
