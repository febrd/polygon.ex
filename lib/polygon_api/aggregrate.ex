defmodule PolygonApi.Aggregrate do

  @type t :: %PolygonApi.Aggregrate{}

  defstruct ~w(
    ticker
    status
    adjusted
    query_count
    results_count
    results
  )a


end
