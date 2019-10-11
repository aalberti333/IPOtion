defmodule IPOtion do
  alias Mojito
  alias Jason

  @moduledoc """
  Returns historical daily pricing
  """

  @doc """
  Select API functionality to use to retrieve financial data

  ## Examples
      iex> IPOtion.api_select "Alpha Vantage"
      {:ok, <start_of_api_url_here>, <end_of_api_url_here>}

  """
  def api_functionality(functionality) do
    # TO DO: add more functionalities
    cond do
      functionality == "TIME_SERIES_DAILY" ->
        {:ok, url_start, url_end} = {:ok, "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=", "&outputsize=full&apikey=" <> System.get_env("ALPHA_KEY")}
      true ->
        raise "You must select a valid api functionality. Available choices are: \"TIME_SERIES_DAILY\", ..."
    end
  end

  @doc """
  Returns historical daily pricing

  ## Examples

      iex> IPOtion.fetch("MSFT", url_start, url_end, functionality)
      %Mojito.Response{ body: "{<market-data-here>}" }

  """
  def fetch(ticker, url_start, url_end, functionality) do
    {:ok, response} = Mojito.request(method: :get, url: url_start <> ticker <> url_end)
    {:ok, ticker_map} = Jason.decode(response.body)

    # TO DO: add more functionalities
    cond do
      functionality == "TIME_SERIES_DAILY" ->
        ticker_map["Time Series (Daily)"]
      true ->
        raise "You must select a valid api functionality. Available choices are: \"TIME_SERIES_DAILY\", ..."
    end
  end

  @doc """
  Converts datetime strings from Alpha Vantage to datetime values. Sorts by date.

  ## Examples

      iex> IPOtion.datestr_to_datetime ticker_map
      [
        {~D[1999-10-11],
        %{
          "1. open" => "94.6226",
          "2. high" => "95.0000",
          "3. low" => "94.1250",
          "4. close" => "94.3130",
          "5. volume" => "19943800"
        }},
        ...
      ]

  """
  def datestr_to_datetime(ticker_map) do
    clean_date = Enum.map(ticker_map, fn {k, v} -> {Date.from_iso8601!(k), v} end)
    sorted_date = Enum.sort_by(clean_date, fn {d, v} -> {{d.year, d.month, d.day}, v} end)
  end

end
