module Bitstamp
  module Exception
    class ServiceError < StandardError
      attr_reader :body

      def initialize(body)
        @body = body
      end

      def message
        @body.fetch('error')
      end

      alias_method :to_s, :message
    end

    class InvalidContent < StandardError
      attr_reader :body

      def initialize(raw_body)
        @raw_body = raw_body
      end

      def message
        "Failed to parse body as 'json': '#{@raw_body}'"
      end

      def inspect
        "#{self.class.name}: #{message}"
      end

      alias_method :to_s, :message
    end
  end
end
