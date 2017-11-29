module Bitstamp
  module Orders
    def open_orders(nonce: nil, currency_pair: nil)
      params = { nonce: nonce }

      if currency_pair == nil
        call(request_uri('v2', 'open_orders', 'all'), 'POST', params)
      else
        call(request_uri('v2', 'open_orders', currency_pair), 'POST', params)
      end
    end

    def order_status(nonce: nil, id:)
      params = { nonce: nonce, id: id }

      call(request_uri('v2', 'order_status'), 'POST', params)
    end

    def cancel_order(nonce: nil, id:)
      params = { nonce: nonce, id: id }

      call(request_uri('v2', 'cancel_order'), 'POST', params)
    end

    def cancel_all_orders(nonce: nil)
      params = { nonce: nonce }

      call(request_uri('cancel_all_orders'), 'POST', params)
    end

    def buy_limit_order(nonce: nil, amount:, price:, limit_price:, currency_pair:)
      params = {
        nonce:       nonce,
        amount:      amount,
        price:       price,
        limit_price: limit_price
      }

      call(request_uri('v2', 'buy', currency_pair), 'POST', params)
    end

    def buy_market_order(nonce: nil, amount:)
      params = {
        nonce:       nonce,
        amount:      amount,
      }

      call(request_uri('v2', 'buy', 'market', currency_pair), 'POST', params)
    end

    def sell_limit_order(nonce: nil, amount:, price:, limit_price:, currency_pair:)
      params = {
        nonce:       nonce,
        amount:      amount,
        price:       price,
        limit_price: limit_price
      }

      call(request_uri('v2', 'sell', currency_pair), 'POST', params)
    end

    def sell_market_order(nonce: nil, amount:)
      params = {
        nonce:       nonce,
        amount:      amount,
      }

      call(request_uri('v2', 'sell', 'market', currency_pair), 'POST', params)
    end
  end
end
