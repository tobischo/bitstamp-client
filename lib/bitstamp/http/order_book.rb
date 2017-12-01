module Bitstamp::HTTP
  module OrderBook
    def order_book(currency_pair: nil)
      if currency_pair == nil
        return call(request_uri('order_book'), 'GET', nil)
      else
        return call(request_uri('v2', 'order_book', currency_pair), 'GET', nil)
      end
    end
  end
end
