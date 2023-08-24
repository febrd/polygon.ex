defmodule ExPolygon.CompanyRatings do
  @type t :: %ExPolygon.CompanyRatings{}

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
