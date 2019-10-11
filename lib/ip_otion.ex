defmodule IPOtion do
  alias Mojito
  alias Jason

  @moduledoc """
  Returns historical daily pricing
  """

  @doc """
  Returns historical daily pricing

  ## Examples

      iex> IPOtion.ticker "MSFT"
      %Mojito.Response{ body: "{<market-data-here>}" }

  """

  # TO DO: Map api to selection.
  def api_select()

  # TO DO: Provide default api if api_select() was not previously called
  def fetch(ticker) do
    url_start = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol="
    url_end = "&outputsize=full&apikey=" <> System.get_env("ALPHA_KEY")

    {:ok, response} = Mojito.request(method: :get, url: url_start <> ticker <> url_end)
    {:ok, ticker_map} = Jason.decode(response.body)

    # TO DO: Add a Enum.map here to generalize the first two elements (MetaData and Time Series (Daily))
    ticker_map["Time Series (Daily)"]
  end

  def datestr_to_datetime(ticker_map) do
    clean_date = Enum.map(ticker_map, fn {k, v} -> {Date.from_iso8601!(k), v} end)
    sorted_date = Enum.sort_by(clean_date, fn {d, v} -> {{d.year, d.month, d.day}, v} end)
  end

end
