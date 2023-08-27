defmodule PolygonApi.Prod.Symbol do
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type symbol :: String.t()
  @type company_detail :: PolygonApi.CompanyData.t()
  @type company_ratings :: PolygonApi.CompanyRates.t()
  @type dividend :: PolygonApi.Dividen.t()
  @type earning :: PolygonApi.Earns.t()
  @type financial :: PolygonApi.Financial.t()

  @path "/v1/meta/symbols"
  @v3_path "https://api.polygon.io/v3/reference"
  @v3_finance "https://api.polygon.io/vX/reference"
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

  @moduledoc """
  DEPRECATED

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

  """

  @spec dividends(symbol, api_key) :: {:ok, map()} | {:error, String.t()}
  def dividends(symbol, api_key) do
    url = dividends_url("/#{@dividends}", symbol, api_key)

    case PolygonApi.Prod.HttpDirect.get(url, %{}) do
      {:ok, json} -> {:ok, json}
      {:error, reason} -> {:error, reason}
    end
  end




  @spec financials(symbol, api_key) :: {:ok, map()} | {:error, String.t()}
  def financials(symbol, api_key) do
    url = financials_url("/#{@financials}", symbol, api_key)

    case PolygonApi.Prod.HttpDirect.get(url, %{}) do
      {:ok, json} -> {:ok, json}
      {:error, reason} -> {:error, reason}
    end
  end




  defp financials_url(path, symbol, api_key) do
    "#{@v3_finance}#{path}?ticker=#{symbol}&apiKey=#{api_key}"
  end



  defp dividends_url(path, symbol, api_key) do
    "#{@v3_path}#{path}?ticker=#{symbol}&apiKey=#{api_key}"
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
