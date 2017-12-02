require 'spec_helper'

describe Bitstamp::HTTP::Ticker do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.ticker' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'ticker', 'btceur')
        .and_return('uri')
    end

    it 'returns the body' do
      expect(object)
        .to receive(:call)
        .with('uri', 'GET', nil)
        .and_return('result')

      expect(object.ticker(currency_pair: 'btceur'))
        .to eq('result')
    end
  end

  context '.hourly_ticker' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'ticker_hour', 'btceur')
        .and_return('uri')
    end

    it 'returns the body' do
      expect(object)
        .to receive(:call)
        .with('uri', 'GET', nil)
        .and_return('result')

      expect(object.hourly_ticker(currency_pair: 'btceur'))
        .to eq('result')
    end
  end
end
