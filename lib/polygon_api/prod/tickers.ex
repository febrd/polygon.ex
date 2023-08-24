defmodule PolygonApi.Prod.Tickers do
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type shared_error_reasons :: PolygonApi.Prod.HttpClient.shared_error_reasons()
  @type tickers :: PolygonApi.Tickers.t()

  @path "/v3/reference/tickers"

  @spec query(map, api_key) :: {:ok, tickers} | {:error, shared_error_reasons}
  def query(params, api_key) do
    with {:ok, data} <- PolygonApi.Prod.HttpClient.get(@path, params, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(%{"tickers" => raw_tickers} = data) do
    tickers =
      raw_tickers
      |> Enum.map(&Mapail.map_to_struct(&1, PolygonApi.Ticker, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    data
    |> Map.put("tickers", tickers)
    |> Mapail.map_to_struct(PolygonApi.Tickers, transformations: [:snake_case])
  end
end
