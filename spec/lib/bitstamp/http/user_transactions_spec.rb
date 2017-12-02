require 'spec_helper'

describe Bitstamp::HTTP::UserTransactions do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.user_transactions' do
    context 'without currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'user_transactions')
          .and_return('uri')
      end

      context 'without nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with(
              'uri',
              'POST',
              {
                nonce:  nil,
                offset: 0,
                limit:  100,
                sort:   'desc'
              }
            )
            .and_return('result')

          expect(object.user_transactions)
            .to eq('result')
        end
      end

      context 'with nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with(
              'uri',
              'POST',
              {
                nonce:  '123',
                offset: 2,
                limit:  12,
                sort:   'asc'
              }
            )
            .and_return('result')

          expect(object.user_transactions(nonce: '123', offset: 2, limit: 12, sort: 'asc'))
            .to eq('result')
        end
      end
    end

    context 'with currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'user_transactions', 'btceur')
          .and_return('uri')
      end

      context 'without nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with(
              'uri',
              'POST',
              {
                nonce:  nil,
                offset: 0,
                limit:  100,
                sort:   'desc'
              }
            )
            .and_return('result')

          expect(object.user_transactions(currency_pair: 'btceur'))
            .to eq('result')
        end
      end

      context 'with nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with(
              'uri',
              'POST',
              {
                nonce:  '123',
                offset: 2,
                limit:  12,
                sort:   'asc'
              }
            )
            .and_return('result')

          expect(
            object.user_transactions(
              nonce:         '123',
              offset:        2,
              limit:         12,
              sort:          'asc',
              currency_pair: 'btceur'
            )
          )
          .to eq('result')
        end
      end
    end
  end
end
