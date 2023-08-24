defmodule PolygonApi.Exchange do
  @type t :: %PolygonApi.Exchange{}

  defstruct ~w(
    id
    type
    market
    mic
    name
    tape
  )a
end
