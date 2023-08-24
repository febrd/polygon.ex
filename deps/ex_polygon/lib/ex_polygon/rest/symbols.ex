defmodule ExPolygon.Rest.Symbols do
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type symbol :: String.t()
  @type company_detail :: ExPolygon.CompanyDetail.t()
  @type company_ratings :: ExPolygon.CompanyRatings.t()
  @type dividend :: ExPolygon.Dividend.t()
  @type earning :: ExPolygon.Earning.t()
  @type financial :: ExPolygon.Financial.t()

  @path "/v1/meta/symbols"
  @details "company"
  @ratings "analysts"
  @dividends "dividends"
  @earnings "earnings"
  @financials "financials"

  @spec company_details(symbol, api_key) :: {:ok, company_detail}
  def company_details(symbol, api_key) do
    [@path, symbol, @details]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response(ExPolygon.CompanyDetail)
  end

  @spec ratings(symbol, api_key) :: {:ok, company_ratings}
  def ratings(symbol, api_key) do
    [@path, symbol, @ratings]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response(ExPolygon.CompanyRatings)
  end

  @spec dividends(symbol, api_key) :: {:ok, [dividend]}
  def dividends(symbol, api_key) do
    [@path, symbol, @dividends]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response([ExPolygon.Dividend])
  end

  @spec earnings(symbol, api_key) :: {:ok, [earning]}
  def earnings(symbol, api_key) do
    [@path, symbol, @earnings]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response([ExPolygon.Earning])
  end

  @spec financials(symbol, api_key) :: {:ok, [financial]}
  def financials(symbol, api_key) do
    [@path, symbol, @financials]
    |> Path.join()
    |> ExPolygon.Rest.HTTPClient.get(%{}, api_key)
    |> parse_response([ExPolygon.Financial])
  end

  defp parse_response({:ok, data}, [mod | _]) do
    list =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, mod, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, list}
  end

  defp parse_response({:ok, data}, mod) do
    {:ok, data} = Mapail.map_to_struct(data, mod, transformations: [:snake_case])
    {:ok, data}
  end
end
