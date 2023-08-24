defmodule PolygonApi.Prod.HttpDirect do
  @endpoint Application.get_env(:polygon_api, "https://api.polygon.io")

  @type api_key :: String.t()
  @type shared_error_reasons :: :timeout | {:unauthorized, String.t()}

  @spec get(String.t(), map, api_key) :: {:ok, map} | {:error, shared_error_reasons}
  def get(path, params, api_key) do
    query_params = Map.put(params, "apiKey", api_key)
    get(build_url(path), query_params, [])
  end

  @spec get(String.t(), map, map) :: {:ok, map} | {:error, shared_error_reasons}
  def get(url, query_params) do
    case HTTPoison.get(url, query_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 401, body: body}} ->
        message = Jason.decode!(body) |> Map.fetch!("message")
        {:error, {:unauthorized, message}}

      {:error, %HTTPoison.Error{reason: :timeout}} ->
        {:error, :timeout}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp build_url(path) do
    URI.merge(@endpoint, path) |> URI.to_string()
  end
end
