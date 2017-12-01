module Bitstamp::HTTP
  module AccountBalance
    def account_balance(nonce: nil, currency_pair: nil)
      params = { nonce: nonce }

      if currency_pair == nil
        call(request_uri('v2', 'balance'), 'POST', params)
      else
        call(request_uri('v2', 'balance', currency_pair), 'POST', params)
      end
    end
  end
end
