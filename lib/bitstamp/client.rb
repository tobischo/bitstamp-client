require 'json'
require 'openssl'
require 'typhoeus'

require_relative './conversion_rates'
require_relative './exception'
require_relative './order_book'
require_relative './ticker'
require_relative './trading_pairs'
require_relative './transactions'

module Bitstamp
  class Client
    BASE_URI = 'https://www.bitstamp.net/api'

    def initialize(customer_id:, api_key:, secret:)
      @customer_id    = customer_id
      @apikey         = api_key
      @secret         = secret

      @connecttimeout = 1
      @timeout        = 10
    end

    class << self
      include ::Bitstamp::ConversionRates
      include ::Bitstamp::OrderBook
      include ::Bitstamp::Ticker
      include ::Bitstamp::TradingPairs
      include ::Bitstamp::Transactions

      def request_uri(*parts)
        uri = BASE_URI

        parts.each do |part|
          uri += "/"
          uri += part
        end

        return uri + "/"
      end

      def call(request_uri, method, body)
        request_hash = {
          method:         method,
          body:           body,
          headers: {
            'User-Agent' => "Bitstamp::Client Ruby v#{::Bitstamp::VERSION}"
          },
          connecttimeout: @connecttimeout,
          timeout:        @timeout,
        }

        request = ::Typhoeus::Request.new(request_uri, request_hash)
        response = request.run

        return handle_response(response)
      end

      def handle_response(response)
        body = JSON.parse(response.body)

        if body.kind_of?(Hash) && body.has_key?('error')
          raise ::Bitstamp::Exception::ServiceError(body)
        end

        return body
      rescue JSON::ParserError
        raise ::Bitstamp::Exception::InvalidContent.new(response.body)
      end
    end

    def account_balance
      # key
      # signature
      # nonce
    end

    def user_transactions
    end

    def open_orders
    end

    def order_status
    end

    def cancel_order
    end

    def cancel_all_orders
    end

    def buy_limit_order
    end

    def buy_market_order
    end

    def sell_limit_order
    end

    def sell_market_order
    end

    def withdrawal_requests
    end

    def bitcoin_withdrawal
    end

    def bitcoin_deposit_address
    end

    def litecoin_withdrawal
    end

    def litecoin_deposit_address
    end

    def etc_withdrawal
    end

    def etc_deposit_address
    end

    def unconfirmed_bitcoin_deposits
    end

    def ripple_withdrawal
    end

    def ripple_deposit_address
    end

    def transfer_to_main
    end

    def transfer_from_main
    end

    def xrp_withdrawal
    end

    def xrp_deposit_address
    end

    def open_bank_withdrawal
    end

    def bank_withdrawal_status
    end

    def cancel_bank_withdrawal
    end

    def new_liquidation_address
    end

    def liquidation_address_info
    end

    private

    def run_request(path:, nonce:, request_params: {})
      body = request_params.merge(
        {
          key:       key,
          signature: signature(nonce),
          nonce:     nonce
        }
      )

      request_uri = BASE_URI + path

      request_hash = {
        method: 'POST',
        body:   body
      }

      request  = ::Typhoeus::Request.new(request_uri, request_hash)
      response = request.run
    end

    def signature(nonce)
      message = nonce + @customer_id + @api_key

      return OpenSSL::HMAC.hexdigest("SHA256", @secret, message)
    end
  end
end
