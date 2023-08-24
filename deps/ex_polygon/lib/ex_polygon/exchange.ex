defmodule ExPolygon.Exchange do
  @type t :: %ExPolygon.Exchange{}

  defstruct ~w(
    id
    type
    market
    mic
    name
    tape
  )a
end
