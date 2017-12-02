require 'spec_helper'

describe Bitstamp::HTTP::Transactions do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.trading_pair_info' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'transactions', 'btceur')
        .and_return('uri')
    end

    it 'returns the body' do
      expect(object)
        .to receive(:call)
        .with('uri', 'GET', nil)
        .and_return('result')

      expect(object.transactions(currency_pair: 'btceur'))
        .to eq('result')
    end
  end
end
