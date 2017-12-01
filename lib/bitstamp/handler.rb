require_relative './exception'

module Bitstamp
  module Handler
    def handle_body(raw_body)
      body = JSON.parse(raw_body)

      if body.kind_of?(Hash) && body.has_key?('error')
        raise ::Bitstamp::Exception::ServiceError(body)
      end

      return body
    rescue JSON::ParserError
      raise ::Bitstamp::Exception::InvalidContent.new(raw_body)
    end
  end
end
