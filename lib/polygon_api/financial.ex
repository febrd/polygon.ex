defmodule PolygonApi.Financial do
  @type t :: %PolygonApi.Financial{}

  defstruct ~w(
    symbol
    report_date
    report_date_str
    gross_profit
    cost_of_revenue
    operating_revenue
    total_revenue
    operating_income
    net_income
    research_and_development
    operating_expense
    current_assets
    total_assets
    total_liabilities
    current_cash
    current_debt
    total_cash
    total_debt
    shareholder_equity
    cash_change
    cash_flow
    operating_gains_losses
  )a
end
