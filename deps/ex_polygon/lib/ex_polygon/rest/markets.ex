defmodule ExPolygon.Rest.Markets do
  @type market :: ExPolygon.Market.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v2/reference/markets"

  @spec query(api_key) :: {:ok, [market]} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- ExPolygon.Rest.HTTPClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  def parse_response(%{"status" => "OK", "results" => results}) do
    markets =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Market, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, markets}
  end
end
