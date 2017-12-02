require 'faye/websocket'
require 'eventmachine'
require 'json'

require_relative './handler'
require_relative './socket'

module Bitstamp
  class Websocket
    include ::Bitstamp::Handler
    include ::Bitstamp::Socket::Orders
    include ::Bitstamp::Socket::Trades

    BASE_URI  = 'wss://ws.pusherapp.com/app/de504dc5763aeef9ff52'
    CLIENT_ID = 'bitstamp-client'
    PROTOCOL  = 7
    PARAMS    = "?client=#{CLIENT_ID}&version=#{Bitstamp::VERSION}&protocol=#{PROTOCOL}"

    def initialize(logger)
      @logger = logger
    end

    def listen(channel, event, block)
      EM.run do
        setup_socket(channel, event, block)
      end
    end

    def setup_socket(channel, event, block)
      websocket = Faye::WebSocket::Client.new(BASE_URI + PARAMS)

      websocket.on(:open) do |message|
        subscribe(websocket, channel)
        @logger.debug("Opened connection and subscribed to '#{channel}'")
      end

      websocket.on(:message) do |message|
        parsed_message = handle_body(message.data)

        case parsed_message.fetch('event')
        when event
          data = handle_body(parsed_message.fetch('data'))
          block.call(data)
        when 'pusher:connection_established'
          @logger.debug('Connection established')
        when 'pusher_internal:subscription_succeeded'
          @logger.debug("Subscription to channel '#{channel}' succeeded")
        else
          @logger.debug("Received unhandled message: #{message.data.to_s}")
        end
      end

      websocket.on(:close) do |message|
        @logger.debug("Closed websocket connection: #{message.data.to_s}")

        return
      end
    end

    def subscribe(websocket, channel)
      subscribe_message = {
        event: 'pusher:subscribe',
        data:  { channel: channel }
      }

      websocket.send(subscribe_message.to_json)
    end
  end
end
