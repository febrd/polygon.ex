defmodule ExPolygon.Rest.Exchanges do
  @type exchange :: ExPolygon.Exchange.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v1/meta/exchanges"

  @spec query(api_key) :: {:ok, [exchange]} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- ExPolygon.Rest.HTTPClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(data) do
    list =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Exchange, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, list}
  end
end
