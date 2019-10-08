# IPOtion

Financial data library using the [Alpha Vantage API](https://www.alphavantage.co/documentation/) used to provide technical indicators for stock prices.

## Before using

You will need your own key from Alpha Vantage. You can get one for yourself [here](https://www.alphavantage.co/support/#api-key).


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `i_p_otion` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:i_p_otion, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/i_p_otion](https://hexdocs.pm/i_p_otion).

## Environment Variables

You will need to create an `env.sh` file and source it before running. It should contain the following:

```bash
export ALPHA_KEY=<your-api-key-from-alpha-vantage>
```