require 'spec_helper'

describe Bitstamp::Handler do
  let(:object) {
    o = Object.new
    o.extend(described_class)
    o
  }

  context '.handle_body' do
    context 'normal body' do
      it 'returns the body' do
        expect(object.handle_body('{"valid":"json"}')).to eq({ 'valid' => 'json' })
      end
    end

    context 'error body' do
      it 'raises ServiceError' do
        expect{
          object.handle_body('{"error":"json"}')
        }.to raise_error(Bitstamp::Exception::ServiceError)
      end
    end

    context 'error body' do
      it 'raises ServiceError' do
        expect{
          object.handle_body('{"status":"error","reason":"something"}')
        }.to raise_error(Bitstamp::Exception::ServiceError)
      end
    end

    context 'invalid json' do
      it 'raises InvalidContent' do
        expect{
          object.handle_body('invalid json')
        }.to raise_error(Bitstamp::Exception::InvalidContent)
      end
    end
  end
end
