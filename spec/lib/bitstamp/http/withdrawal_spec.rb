require 'spec_helper'

describe Bitstamp::HTTP::Withdrawal do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.withdrawal_requests' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'withdrawal-requests')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil, timedelta: 86400 })
          .and_return('result')

        expect(object.withdrawal_requests)
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123', timedelta: 86400 })
          .and_return('result')

        expect(object.withdrawal_requests(nonce: '123'))
          .to eq('result')
      end

      it 'requests with timedelta' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123', timedelta: 10000 })
          .and_return('result')

        expect(object.withdrawal_requests(nonce: '123', timedelta: 10000))
          .to eq('result')
      end
    end
  end

  context '.bitcoin_withdrawal' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('bitcoin_withdrawal')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil, amount: 0.1, address: 'asd' })
          .and_return('result')

        expect(object.bitcoin_withdrawal(amount: 0.1, address: 'asd'))
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123', amount: 0.1, address: 'asd' })
          .and_return('result')

        expect(object.bitcoin_withdrawal(nonce: '123', amount: 0.1, address: 'asd'))
          .to eq('result')
      end
    end
  end
end
