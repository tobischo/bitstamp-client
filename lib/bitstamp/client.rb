require 'forwardable'
require 'json'
require 'openssl'
require 'typhoeus'

require_relative './account_balance'
require_relative './deposit'
require_relative './conversion_rates'
require_relative './exception'
require_relative './order_book'
require_relative './orders'
require_relative './subaccount_transfer'
require_relative './ticker'
require_relative './trading_pairs'
require_relative './transactions'
require_relative './user_transactions'
require_relative './withdrawal'

module Bitstamp
  class Client
    extend Forwardable

    BASE_URI = 'https://www.bitstamp.net/api'

    def initialize(customer_id:, api_key:, secret:)
      @customer_id    = customer_id
      @api_key        = api_key
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
          method:  method,
          body:    body,
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

    def_delegators "Bitstamp::Client", :request_uri, :handle_response

    include ::Bitstamp::AccountBalance
    include ::Bitstamp::Deposit
    include ::Bitstamp::Orders
    include ::Bitstamp::SubaccountTransfer
    include ::Bitstamp::UserTransactions
    include ::Bitstamp::Withdrawal

    def call(request_uri, method, body)
      body = params_with_signature(body)

      ::Bitstamp::Client.call(request_uri, method, body)
    end

    def params_with_signature(params = {})
      if params[:nonce] == nil
        params[:nonce] = (Time.now.to_f * 1000000).to_i.to_s # Microseconds
      end

      params[:key]       = @api_key
      params[:signature] = build_signature(params[:nonce])

      return params
    end

    def build_signature(nonce)
      message = nonce + @customer_id + @api_key

      return OpenSSL::HMAC.hexdigest("SHA256", @secret, message).upcase
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
