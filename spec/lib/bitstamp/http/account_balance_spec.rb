require 'spec_helper'

describe Bitstamp::HTTP::AccountBalance do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.account_balance' do
    context 'without currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'balance')
          .and_return('uri')
      end

      context 'without nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: nil })
            .and_return('result')

          expect(object.account_balance)
            .to eq('result')
        end
      end

      context 'with nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: '123' })
            .and_return('result')

          expect(object.account_balance(nonce: '123'))
            .to eq('result')
        end
      end
    end

    context 'with currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'balance', 'btceur')
          .and_return('uri')
      end

      context 'without nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: nil })
            .and_return('result')

          expect(object.account_balance(currency_pair: 'btceur'))
            .to eq('result')
        end
      end

      context 'with nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: '123' })
            .and_return('result')

          expect(object.account_balance(nonce: '123', currency_pair: 'btceur'))
            .to eq('result')
        end
      end
    end
  end
end
