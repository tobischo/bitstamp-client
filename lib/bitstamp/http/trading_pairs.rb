module Bitstamp::HTTP
  module TradingPairs
    def trading_pair_info
      return call(request_uri('v2', 'trading-pair-info'), 'GET', nil)
    end
  end
end
