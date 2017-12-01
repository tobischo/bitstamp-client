module Bitstamp::HTTP
  module Deposit
    def bitcoin_deposit_address(nonce: nil)
      params = { nonce: nonce }

      call(request_uri('bitcoin_deposit_address'), 'POST', params)
    end

    def unconfirmed_bitcoin_deposits(nonce: nil)
      params = { nonce: nonce }

      call(request_uri('unconfirmed_btc'), 'POST', params)
    end
  end
end
