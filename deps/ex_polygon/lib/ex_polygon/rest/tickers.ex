defmodule ExPolygon.Rest.Tickers do
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()
  @type tickers :: ExPolygon.Tickers.t()

  @path "/v2/reference/tickers"

  @spec query(map, api_key) :: {:ok, tickers} | {:error, shared_error_reasons}
  def query(params, api_key) do
    with {:ok, data} <- ExPolygon.Rest.HTTPClient.get(@path, params, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(%{"tickers" => raw_tickers} = data) do
    tickers =
      raw_tickers
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Ticker, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    data
    |> Map.put("tickers", tickers)
    |> Mapail.map_to_struct(ExPolygon.Tickers, transformations: [:snake_case])
  end
end
