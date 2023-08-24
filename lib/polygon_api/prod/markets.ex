defmodule PolygonApi.Prod.Markets do
  @type market :: PolygonApi.Markets.t()
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type shared_error_reasons :: PolygonApi.Prod.HttpClient.shared_error_reasons()

  @path "/v2/reference/markets"

  @spec query(api_key) :: {:ok, [market]} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- PolygonApi.Prod.HttpClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  @spec parse_response(map) :: {:ok, list}
  def parse_response(%{"status" => "OK", "results" => results}) do
    markets =
      results
      |> Enum.map(&Mapail.map_to_struct(&1,PolygonApi.Markets, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, markets}
  end
end
