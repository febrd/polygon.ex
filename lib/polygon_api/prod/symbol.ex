defmodule PolygonApi.Prod.Symbol do
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type symbol :: String.t()
  @type company_detail :: PolygonApi.CompanyData.t()
  @type company_ratings :: PolygonApi.CompanyRates.t()
  @type dividend :: PolygonApi.Dividen.t()
  @type earning :: PolygonApi.Earns.t()
  @type financial :: PolygonApi.Financial.t()

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
    |> PolygonApi.Prod.HttpClient.get(%{}, api_key)
    |> parse_response(PolygonApi.CompanyData)
  end

  @spec ratings(symbol, api_key) :: {:ok, company_ratings}
  def ratings(symbol, api_key) do
    [@path, symbol, @ratings]
    |> Path.join()
    |> PolygonApi.Prod.HttpClient.get(%{}, api_key)
    |> parse_response(PolygonApi.CompanyRates)
  end

  @spec dividends(symbol, api_key) :: {:ok, [dividend]}
  def dividends(symbol, api_key) do
    [@path, symbol, @dividends]
    |> Path.join()
    |> PolygonApi.Prod.HttpClient.get(%{}, api_key)
    |> parse_response([PolygonApi.Dividen])
  end

  @spec earnings(symbol, api_key) :: {:ok, [earning]}
  def earnings(symbol, api_key) do
    [@path, symbol, @earnings]
    |> Path.join()
    |> PolygonApi.Prod.HttpClient.get(%{}, api_key)
    |> parse_response([PolygonApi.Earns])
  end

  @spec financials(symbol, api_key) :: {:ok, [financial]}
  def financials(symbol, api_key) do
    [@path, symbol, @financials]
    |> Path.join()
    |>  PolygonApi.Prod.HttpClient.get(%{}, api_key)
    |> parse_response([PolygonApi.Financial])
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
