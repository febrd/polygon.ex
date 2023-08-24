defmodule ExPolygon.Rest.Locales do
  @type locale :: ExPolygon.Locale.t()
  @type api_key :: ExPolygon.Rest.HTTPClient.api_key()
  @type shared_error_reasons :: ExPolygon.Rest.HTTPClient.shared_error_reasons()

  @path "/v2/reference/locales"

  @spec query(api_key) :: {:ok, [locale]} | {:error, shared_error_reasons}
  def query(api_key) do
    with {:ok, data} <- ExPolygon.Rest.HTTPClient.get(@path, %{}, api_key) do
      parse_response(data)
    end
  end

  defp parse_response(%{"status" => "OK", "results" => results}) do
    locales =
      results
      |> Enum.map(&Mapail.map_to_struct(&1, ExPolygon.Locale, transformations: [:snake_case]))
      |> Enum.map(fn {:ok, t} -> t end)

    {:ok, locales}
  end
end
