module Bitstamp
  module TradingPairs
    def trading_pair_info
      return call(request_uri('trading-pair-info'), 'GET', nil)
    end
  end
end
