require 'spec_helper'

describe Bitstamp::Exception::ServiceError do
  let(:message) { 'something went wrong' }

  let(:exception) {
    described_class.new(message)
  }

  it 'returns the message' do
    expect(exception.message).to eq('something went wrong')

    expect(exception.to_s).to eq('something went wrong')
  end
end

describe Bitstamp::Exception::InvalidContent do
  let(:raw_body) { 'invalid_body' }

  let(:exception) {
    described_class.new(raw_body)
  }

  let(:message) { "Failed to parse body as 'json': '#{raw_body}'" }

  it 'returns the proper message' do
    expect(exception.message).to eq(message)

    expect(exception.to_s).to eq(message)

    expect(exception.inspect).to eq("#{described_class}: #{message}")
  end
end
