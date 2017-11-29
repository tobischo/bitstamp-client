module Bitstamp
  module SubaccountTransfer
    def transfer_to_main(nonce: nil, amount:, currency:, sub_account:)
      params = {
        nonce:      nonce,
        amount:     amount,
        currency:   currency,
        subAccount: sub_account
      }

      call(request_uri('v2', 'transfer-to-main'), 'POST', params)
    end

    def transfer_from_main(nonce: nil, amount:, currency:, sub_account:)
      params = {
        nonce:      nonce,
        amount:     amount,
        currency:   currency,
        subAccount: sub_account
      }

      call(request_uri('v2', 'transfer-from-main'), 'POST', params)
    end
  end
end
