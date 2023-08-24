defmodule ExPolygon.Aggregate do
  @type t :: %ExPolygon.Aggregate{}

  defstruct ~w(
    ticker
    status
    adjusted
    query_count
    results_count
    results
  )a
end
