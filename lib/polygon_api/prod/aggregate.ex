defmodule PolygonApi.Prod.Aggregate do
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type shared_error_reasons :: PolygonApi.Prod.HttpClient.shared_error_reasons()
  @type aggregate :: PolygonApi.Aggregrate.t()

  @path "/v2/aggs/ticker/:symbol/range/:multiplier/:timespan/:from/:to"

  @spec query(
          String.t(),
          non_neg_integer | String.t(),
          String.t(),
          String.t(),
          String.t(),
          api_key
        ) ::
          {:ok, aggregate} | {:error, shared_error_reasons}
  def query(symbol, multiplier, timespan, from, to, api_key) when is_integer(multiplier) do
    query(symbol, multiplier |> Integer.to_string(), timespan, from, to, api_key)
  end

  def query(symbol, multiplier, timespan, from, to, api_key) do
    with {:ok, data} <-
           @path
           |> String.replace(":symbol", symbol)
           |> String.replace(":multiplier", multiplier)
           |> String.replace(":timespan", timespan)
           |> String.replace(":from", from)
           |> String.replace(":to", to)
           |> PolygonApi.Prod.HttpClient.get(%{}, api_key) do
      parse_response(data)
    end
  end

  def parse_response(%{"results" => results} = data) do
    results =
      results
      |> Enum.map(
        &Mapail.map_to_struct(&1, PolygonApi.AggregrateOutput, transformations: [:snake_case])
      )
      |> Enum.map(fn {:ok, result} -> result end)

    {:ok, aggregate} =
      data
      |> Map.put("results", results)
      |> Mapail.map_to_struct(PolygonApi.Aggregrate, transformations: [:snake_case])

    {:ok, aggregate}
  end
end
