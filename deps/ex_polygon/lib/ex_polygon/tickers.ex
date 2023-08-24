defmodule ExPolygon.Tickers do
  @type t :: %ExPolygon.Tickers{}

  defstruct ~w(count page per_page status tickers)a
end
