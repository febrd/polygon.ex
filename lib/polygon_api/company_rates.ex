defmodule PolygonApi.CompanyRates do
  @type t :: %PolygonApi.CompanyRates{}

  defstruct ~w(
    symbol
    analysts
    change
    strong_buy
    buy
    hold
    sell
    strong_sell
    updated
  )a
end
