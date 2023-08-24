defmodule PolygonApi.Earns do


  @type t :: %PolygonApi.Earns{}

  defstruct ~w(
    symbol
    eps_report_date
    fiscal_period
    fiscal_end_date
    actual_eps
    consensus_eps
    estimated_eps
    announce_time
    number_of_estimates
    eps_surprise_dollar
  )a

end
