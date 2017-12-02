require 'spec_helper'

describe Bitstamp::HTTP::ConversionRates do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.eur_usd_conversion_rate' do
    before do
      expect(object)
        .to receive(:request_uri)
        .with('eur_usd')
        .and_return('uri')
    end

    it 'returns the body' do
      expect(object)
        .to receive(:call)
        .with('uri', 'GET', nil)
        .and_return('result')

      expect(object.eur_usd_conversion_rate)
        .to eq('result')
    end
  end
end
