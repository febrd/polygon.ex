defmodule PolygonApi.Prod.Locales do
  @type locale :: PolygonApi.Local.t()
  @type api_key :: PolygonApi.Prod.HttpClient.api_key()
  @type shared_error_reasons :: PolygonApi.Prod.HttpClient.shared_error_reasons()

  @path "/v2/reference/locales"

  @spec query(api_key) :: {:ok, [locale]} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- PolygonApi.Prod.HttpClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(%{"status" => "OK", "results" => results}) do
    locales =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, PolygonApi.Local, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, locales}
  end
end
