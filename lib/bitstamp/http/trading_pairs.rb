module Bitstamp::HTTP
  module TradingPairs
    def trading_pair_info
      return call(request_uri('v2', 'trading-pairs-info'), 'GET', nil)
    end
  end
end
