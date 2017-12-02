require 'spec_helper'

describe Bitstamp::Websocket do
  let(:logger) { double('logger') }

  let(:client) { described_class.new(logger) }

  describe '#listen' do
    before do
      expect(EM)
        .to receive(:run)
        .and_yield

      expect(client)
        .to receive(:setup_socket)
        .with('channel', 'event', 'block')
    end

    it 'calls setup_socket' do
      client.listen('channel', 'event', 'block')
    end
  end

  describe '#setup_socket' do
    let(:websocket) { instance_double(Faye::WebSocket::Client) }
    let(:message)   { double('message') }
    let(:data)      { 'data' }
    let(:block)     { double('block') }

    before do
      allow(message)
        .to receive(:data)
        .and_return(data)

      expect(Faye::WebSocket::Client)
        .to receive(:new)
        .with(
          'wss://ws.pusherapp.com/app/de504dc5763aeef9ff52' +
          "?client=bitstamp-client&version=#{Bitstamp::VERSION}&protocol=7"
        )
        .and_return(websocket)

      expect(websocket)
        .to receive(:on)
        .with(:open)
        .and_yield(message)

      expect(websocket)
        .to receive(:send)
        .with({
          event: 'pusher:subscribe',
          data:  { channel: 'channel' }
        }.to_json)

      expect(logger)
        .to receive(:debug)
        .with("Opened connection and subscribed to 'channel'")

      expect(websocket)
        .to receive(:on)
        .with(:close)
        .and_yield(message)

      expect(logger)
        .to receive(:debug)
        .with("Closed websocket connection: #{data}")

      expect(websocket)
        .to receive(:on)
        .with(:message)
        .and_yield(message)
    end

    context 'expected event' do
      let(:data) {
        { 'event' => 'event', 'data' => { 'key' => 'value' }.to_json }.to_json
      }


      it 'calls the given block' do
        expect(block)
          .to receive(:call)
          .with({ 'key' => 'value' })

        client.setup_socket('channel', 'event', block)
      end
    end

    context 'connection established' do
      let(:data) {
        { "event" => "pusher:connection_established" }.to_json
      }

      before do
        expect(logger)
          .to receive(:debug)
          .with('Connection established')
      end

      it 'logs connection established' do
        client.setup_socket('channel', 'event', block)
      end
    end

    context 'subscription succeeded' do
      let(:data) {
        { 'event' => 'pusher_internal:subscription_succeeded' }.to_json
      }

      before do
        expect(logger)
          .to receive(:debug)
          .with("Subscription to channel 'channel' succeeded")
      end

      it 'logs subscription succeeded' do
        client.setup_socket('channel', 'event', block)
      end
    end

    context 'unhandled message' do
      let(:data) {
        { 'event' => 'unhandled_event' }.to_json
      }

      before do
        expect(logger)
          .to receive(:debug)
          .with("Received unhandled message: #{data}")
      end

      it 'received unhandle message' do
        client.setup_socket('channel', 'event', block)
      end
    end
  end
end
