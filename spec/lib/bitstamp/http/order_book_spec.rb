require 'spec_helper'

describe Bitstamp::HTTP::OrderBook do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.order_book' do
    context 'without currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('order_book')
          .and_return('uri')
      end

      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'GET', nil)
          .and_return('result')

        expect(object.order_book)
          .to eq('result')
      end
    end

    context 'with currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'order_book', 'btceur')
          .and_return('uri')
      end

      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'GET', nil)
          .and_return('result')

        expect(object.order_book(currency_pair: 'btceur'))
          .to eq('result')
      end
    end
  end
end
