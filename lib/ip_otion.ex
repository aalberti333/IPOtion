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

  def ticker(tick) do
    url_start = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol="
    url_end = "&outputsize=full&apikey=" <> System.get_env("ALPHA_KEY")

    {:ok, response} = Mojito.request(method: :get, url: url_start <> tick <> url_end)

    ticker_map = Jason.decode(response.body)
    IO.inspect(ticker_map)
  end
end
