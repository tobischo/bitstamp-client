require 'forwardable'
require 'json'
require 'openssl'
require 'typhoeus'

require_relative './handler'
require_relative './http'

module Bitstamp
  class Client
    extend Forwardable

    BASE_URI = 'https://www.bitstamp.net/api'

    CONNECTTIMEOUT = 1
    TIMEOUT        = 10


    def initialize(customer_id:, api_key:, secret:)
      @customer_id    = customer_id
      @api_key        = api_key
      @secret         = secret
    end

    class << self
      include ::Bitstamp::Handler
      include ::Bitstamp::HTTP::ConversionRates
      include ::Bitstamp::HTTP::OrderBook
      include ::Bitstamp::HTTP::Ticker
      include ::Bitstamp::HTTP::TradingPairs
      include ::Bitstamp::HTTP::Transactions

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
          connecttimeout: CONNECTTIMEOUT,
          timeout:        TIMEOUT
        }

        request = ::Typhoeus::Request.new(request_uri, request_hash)
        response = request.run

        return handle_body(response.body)
      end
    end

    def_delegators "Bitstamp::Client", :request_uri

    include ::Bitstamp::HTTP::AccountBalance
    include ::Bitstamp::HTTP::Deposit
    include ::Bitstamp::HTTP::Orders
    include ::Bitstamp::HTTP::SubaccountTransfer
    include ::Bitstamp::HTTP::UserTransactions
    include ::Bitstamp::HTTP::Withdrawal

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
  end
end
