require 'spec_helper'

describe Bitstamp::HTTP::TradingPairs do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.trading_pair_info' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'trading-pair-info')
        .and_return('uri')
    end

    it 'returns the body' do
      expect(object)
        .to receive(:call)
        .with('uri', 'GET', nil)
        .and_return('result')

      expect(object.trading_pair_info)
        .to eq('result')
    end
  end
end
