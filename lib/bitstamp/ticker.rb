module Bitstamp
  module Ticker
    def ticker(currency_pair: nil)
      if currency_pair == nil
        return call(request_uri('ticker'), 'GET', nil)
      else
        return call(request_uri('v2', 'ticker', currency_pair), 'GET', nil)
      end
    end

    def hourly_ticker(currency_pair: nil)
      if currency_pair == nil
        return call(request_uri('ticker_hour'), 'GET', nil)
      else
        return call(request_uri('v2', 'ticker_hour', currency_pair), 'GET', nil)
      end
    end
  end
end
