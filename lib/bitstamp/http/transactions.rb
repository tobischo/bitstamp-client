module Bitstamp::HTTP
  module Transactions
    def transactions(currency_pair:)
      return call(request_uri('v2', 'transactions', currency_pair), 'GET', nil)
    end
  end
end
