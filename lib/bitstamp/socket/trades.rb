module Bitstamp::Socket
  module Trades
    def live_trades(currency_pair:, &block)
      channel = "live_trades_#{currency_pair}"
      event   = 'trade'

      listen(channel, event, block)
    end
  end
end
