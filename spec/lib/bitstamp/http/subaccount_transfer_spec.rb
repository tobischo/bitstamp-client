require 'spec_helper'

describe Bitstamp::HTTP::SubaccountTransfer do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.transfer_to_main' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'transfer-to-main')
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
              nonce:      nil,
              amount:     0.1,
              currency:   'btc',
              subAccount: '32as'
            }
          )
          .and_return('result')

        expect(
          object.transfer_to_main(
            amount:      0.1,
            currency:    'btc',
            sub_account: '32as'
          )
        )
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
              nonce:      'abc',
              amount:     0.1,
              currency:   'btc',
              subAccount: '32as'
            }
          )
          .and_return('result')

        expect(
          object.transfer_to_main(
            nonce:       'abc',
            amount:      0.1,
            currency:    'btc',
            sub_account: '32as'
          )
        )
        .to eq('result')
      end
    end
  end

  context '.transfer_from_main' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'transfer-from-main')
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
              nonce:      nil,
              amount:     0.1,
              currency:   'btc',
              subAccount: '32as'
            }
          )
          .and_return('result')

        expect(
          object.transfer_from_main(
            amount:      0.1,
            currency:    'btc',
            sub_account: '32as'
          )
        )
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
              nonce:      'abc',
              amount:     0.1,
              currency:   'btc',
              subAccount: '32as'
            }
          )
          .and_return('result')

        expect(
          object.transfer_from_main(
            nonce:       'abc',
            amount:      0.1,
            currency:    'btc',
            sub_account: '32as'
          )
        )
        .to eq('result')
      end
    end
  end
end
