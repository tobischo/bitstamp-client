module Bitstamp::HTTP
  module Withdrawal
    def withdrawal_requests(nonce: nil, timedelta: 86400)
      params = { nonce: nonce, timedelta: timedelta }

      call(request_uri('v2', 'withdrawal-requests'), 'POST', params)
    end

    def bitcoin_withdrawal(nonce: nil, amount:, address:)
      params = {
        nonce:   nonce,
        amount:  amount,
        address: address
      }

      call(request_uri('bitcoin_withdrawal'), 'POST', params)
    end
  end
end
