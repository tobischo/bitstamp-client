module Bitstamp::HTTP
  module Transactions
    def transactions(currency_pair: nil)
      if currency_pair == nil
        return call(request_uri('transactions'), 'GET', nil)
      else
        return call(request_uri('v2', 'transactions', currency_pair, ''), 'GET', nil)
      end
    end
  end
end
