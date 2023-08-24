defmodule PolygonApi.Dividen do
  @type t :: %PolygonApi.Dividen{}

  defstruct ~w(
    symbol
    type
    ex_date
    payment_date
    record_date
    declared_date
    amount
    qualified
    flag
  )a
end
