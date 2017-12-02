require 'spec_helper'

describe Bitstamp::HTTP::Orders do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.open_orders' do
    context 'without currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'open_orders', 'all')
          .and_return('uri')
      end

      context 'without nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: nil })
            .and_return('result')

          expect(object.open_orders)
            .to eq('result')
        end
      end

      context 'with nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: '123' })
            .and_return('result')

          expect(object.open_orders(nonce: '123'))
            .to eq('result')
        end
      end
    end

    context 'with currency_pair' do
      before do
        expect(object)
          .to receive(:request_uri)
          .with('v2', 'open_orders', 'btceur')
          .and_return('uri')
      end

      context 'without nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: nil })
            .and_return('result')

          expect(object.open_orders(currency_pair: 'btceur'))
            .to eq('result')
        end
      end

      context 'with nonce' do
        it 'returns the body' do
          expect(object)
            .to receive(:call)
            .with('uri', 'POST', { nonce: '123' })
            .and_return('result')

          expect(object.open_orders(nonce: '123', currency_pair: 'btceur'))
            .to eq('result')
        end
      end
    end
  end

  context '.order_status' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'order_status')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil, id: 123 })
          .and_return('result')

        expect(object.order_status(id: 123))
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123', id: 123 })
          .and_return('result')

        expect(object.order_status(nonce: '123', id: 123))
          .to eq('result')
      end
    end
  end

  context '.cancel_order' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'cancel_order')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil, id: 123 })
          .and_return('result')

        expect(object.cancel_order(id: 123))
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123', id: 123 })
          .and_return('result')

        expect(object.cancel_order(nonce: '123', id: 123))
          .to eq('result')
      end
    end
  end

  context '.cancel_all_orders' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('cancel_all_orders')
        .and_return('uri')
    end

    context 'without nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: nil })
          .and_return('result')

        expect(object.cancel_all_orders)
          .to eq('result')
      end
    end

    context 'with nonce' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with('uri', 'POST', { nonce: '123' })
          .and_return('result')

        expect(object.cancel_all_orders(nonce: '123'))
          .to eq('result')
      end
    end
  end

  context '.buy_limit_order' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'buy', 'btceur')
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
              nonce:       nil,
              amount:      0.1,
              price:       9000,
              limit_price: 9100
            }
          )
          .and_return('result')

        expect(
          object.buy_limit_order(
            amount:        0.1,
            price:         9000,
            limit_price:   9100,
            currency_pair: 'btceur'
          )
        )
        .to eq('result')
      end
    end

    context 'without limit_price' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with(
            'uri',
            'POST',
            {
              nonce:  nil,
              amount: 0.1,
              price:  9000
            }
          )
          .and_return('result')

        expect(
          object.buy_limit_order(
            amount:        0.1,
            price:         9000,
            currency_pair: 'btceur'
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
              nonce:       '123',
              amount:      0.1,
              price:       9000,
              limit_price: 9100
            }
          )
          .and_return('result')

        expect(
          object.buy_limit_order(
            nonce:         '123',
            amount:        0.1,
            price:         9000,
            limit_price:   9100,
            currency_pair: 'btceur'
          )
        )
        .to eq('result')
      end
    end
  end

  context '.buy_market_order' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'buy', 'market', 'btceur')
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
              amount: 0.1
            }
          )
          .and_return('result')

        expect(
          object.buy_market_order(
            amount:        0.1,
            currency_pair: 'btceur'
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
              nonce:  '123',
              amount: 0.1,
            }
          )
          .and_return('result')

        expect(
          object.buy_market_order(
            nonce:         '123',
            amount:        0.1,
            currency_pair: 'btceur'
          )
        )
        .to eq('result')
      end
    end
  end

  context '.sell_limit_order' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'sell', 'btceur')
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
              nonce:       nil,
              amount:      0.1,
              price:       9000,
              limit_price: 9100
            }
          )
          .and_return('result')

        expect(
          object.sell_limit_order(
            amount:        0.1,
            price:         9000,
            limit_price:   9100,
            currency_pair: 'btceur'
          )
        )
        .to eq('result')
      end
    end

    context 'without limit_price' do
      it 'returns the body' do
        expect(object)
          .to receive(:call)
          .with(
            'uri',
            'POST',
            {
              nonce:  nil,
              amount: 0.1,
              price:  9000
            }
          )
          .and_return('result')

        expect(
          object.sell_limit_order(
            amount:        0.1,
            price:         9000,
            currency_pair: 'btceur'
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
              nonce:       '123',
              amount:      0.1,
              price:       9000,
              limit_price: 9100
            }
          )
          .and_return('result')

        expect(
          object.sell_limit_order(
            nonce:         '123',
            amount:        0.1,
            price:         9000,
            limit_price:   9100,
            currency_pair: 'btceur'
          )
        )
        .to eq('result')
      end
    end
  end

  context '.sell_market_order' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('v2', 'sell', 'market', 'btceur')
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
              amount: 0.1
            }
          )
          .and_return('result')

        expect(
          object.sell_market_order(
            amount:        0.1,
            currency_pair: 'btceur'
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
              nonce:  '123',
              amount: 0.1,
            }
          )
          .and_return('result')

        expect(
          object.sell_market_order(
            nonce:         '123',
            amount:        0.1,
            currency_pair: 'btceur'
          )
        )
        .to eq('result')
      end
    end
  end
end
