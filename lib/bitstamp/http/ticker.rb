module Bitstamp::HTTP
  module Ticker
    def ticker(currency_pair:)
      return call(request_uri('v2', 'ticker', currency_pair), 'GET', nil)
    end

    def hourly_ticker(currency_pair:)
      return call(request_uri('v2', 'ticker_hour', currency_pair), 'GET', nil)
    end
  end
end
