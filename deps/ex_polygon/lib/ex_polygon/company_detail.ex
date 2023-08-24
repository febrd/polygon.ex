defmodule ExPolygon.CompanyDetail do
  @type t :: %ExPolygon.CompanyDetail{}

  defstruct ~w(
    active
    bloomberg
    ceo
    cik
    country
    description
    employees
    exchange
    exchange_symbol
    figi
    hq_address
    hq_country
    hq_state
    industry
    lei
    listdate
    logo
    marketcap
    name
    phone
    sector
    sic
    similar
    symbol
    tags
    type
    updated
    url
  )a
end
