require 'spec_helper'

describe Bitstamp::Socket::Orders do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  describe '.live_order_book' do
    it 'calls listen' do
      expect(object)
        .to receive(:listen)
        .with('order_book_btceur', 'data', an_instance_of(Proc))

      object.live_order_book(currency_pair: 'btceur') do
        # block
      end
    end
  end

  describe '.live_orders_created' do
    it 'calls listen' do
      expect(object)
        .to receive(:listen)
        .with('live_orders_btceur', 'order_created', an_instance_of(Proc))

      object.live_orders_created(currency_pair: 'btceur') do
        # block
      end
    end
  end

  describe '.live_orders_changed' do
    it 'calls listen' do
      expect(object)
        .to receive(:listen)
        .with('live_orders_btceur', 'order_changed', an_instance_of(Proc))

      object.live_orders_changed(currency_pair: 'btceur') do
        # block
      end
    end
  end

  describe '.live_orders_deleted' do
    it 'calls listen' do
      expect(object)
        .to receive(:listen)
        .with('live_orders_btceur', 'order_deleted', an_instance_of(Proc))

      object.live_orders_deleted(currency_pair: 'btceur') do
        # block
      end
    end
  end

  describe '.live_full_order_book' do
    it 'calls listen' do
      expect(object)
        .to receive(:listen)
        .with('diff_order_book_btceur', 'data', an_instance_of(Proc))

      object.live_full_order_book(currency_pair: 'btceur') do
        # block
      end
    end
  end
end
