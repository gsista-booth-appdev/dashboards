class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    render({ :template => "/currency_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    @from_symbol = params.fetch("from_currency")

    render({ :template => "/currency_templates/step_two.html.erb" })
  end

  def third_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    @from_symbol = params.fetch("from_currency")
    @to_symbol = params.fetch("to_currency")

    @api_exchangerate_host_url = "https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_symbol}"

    @raw_currency_conversion_data = open(@api_exchangerate_host_url).read
    @parsed_raw_currency_conversion_data = JSON.parse(@raw_currency_conversion_data)

    @from_amount = @parsed_raw_currency_conversion_data.fetch("query").fetch("amount")
    @to_rate = @parsed_raw_currency_conversion_data.fetch("info").fetch("rate")

    render({ :template => "/currency_templates/step_three.html.erb" })
  end
end
