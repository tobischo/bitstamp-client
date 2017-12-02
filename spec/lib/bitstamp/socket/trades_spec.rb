require 'spec_helper'

describe Bitstamp::Socket::Trades do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  describe '.live_trades' do
    it 'calls listen' do
      expect(object)
        .to receive(:listen)
        .with('live_trades_btceur', 'trade', an_instance_of(Proc))

      object.live_trades(currency_pair: 'btceur') do
        # block
      end
    end
  end
end
