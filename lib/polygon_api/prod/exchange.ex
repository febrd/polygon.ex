defmodule PolygonApi.Prod.Exchange do
  @type exchange :: PolygonApi.Exchange.t()
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type shared_error_reasons :: PolygonApi.Prod.HttpClient.shared_error_reasons()

  @path "/v1/meta/exchanges"

  @spec query(api_key) :: {:ok, [exchange]} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- PolygonApi.Prod.HttpClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(data) do
    list =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, PolygonApi.Exchange, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, list}
  end
end
