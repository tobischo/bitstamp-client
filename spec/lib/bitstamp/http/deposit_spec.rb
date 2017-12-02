require 'spec_helper'

describe Bitstamp::HTTP::Deposit do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.bitcoin_deposit_address' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('bitcoin_deposit_address')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil })
          .and_return('result')

        expect(object.bitcoin_deposit_address)
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123' })
          .and_return('result')

        expect(object.bitcoin_deposit_address(nonce: '123'))
          .to eq('result')
      end
    end
  end

  context '.unconfirmed_bitcoin_deposits' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('unconfirmed_btc')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil })
          .and_return('result')

        expect(object.unconfirmed_bitcoin_deposits)
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123' })
          .and_return('result')

        expect(object.unconfirmed_bitcoin_deposits(nonce: '123'))
          .to eq('result')
      end
    end
  end
end
