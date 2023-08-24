defmodule PolygonApi.Prod.HttpClient do
  @endpoint :polygon_api
  |> Application.get_env(:endpoint, "https://api.polygon.io")
  |> URI.parse()

  @type api_key :: String.t()
  @type shared_error_reasons :: :timeout | {:unauthorized, String.t()}

  @spec get(String.t(), map, api_key) :: {:ok, map} | {:error, shared_error_reasons}
  def get(path, params, api_key) do
    query_params = params |> Map.put(:apiKey, api_key)
    path |> get(query_params)
  end

  @spec get(String.t(), map) :: {:ok, map} | {:error, shared_error_reasons}
  def get(path, query_params) do
    path
    |> url(query_params)
    |> HTTPoison.get()
    |> parse_response
  end

  def url(path, query), do: %URI{path: path, query: query |> URI.encode_query()} |> url()
  def url(%URI{} = u), do: @endpoint |> URI.merge(u) |> URI.to_string()

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    data = Jason.decode!(body)
    {:ok, data}
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: 401, body: body}}) do
    message = Jason.decode!(body) |> Map.fetch!("message")
    {:error, {:unauthorized, message}}
  end

  defp parse_response({:error, %HTTPoison.Error{reason: :timeout}}) do
    {:error, :timeout}
  end
end
