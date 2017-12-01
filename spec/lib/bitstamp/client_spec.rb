require 'spec_helper'
require 'time'

describe Bitstamp::Client do
  let(:customer_id) { 'customer_id' }
  let(:api_key)     { 'api_key' }
  let(:secret)      { 'secret' }

  let(:client) {
    described_class.new(
      customer_id: customer_id,
      api_key:     api_key,
      secret:      secret
    )
  }

  describe '.request_uri' do
    it 'builds the request URI from the given parts' do
      expect(described_class.request_uri('v2', 'sub', 'part'))
        .to eq(Bitstamp::Client::BASE_URI + '/v2/sub/part/')
    end
  end

  describe '.call' do
    it 'builds the request and executes it' do
      response = Typhoeus::Response.new(code: 200, body: '{"name" : "paul"}')

      request = double('request')

      expect(Typhoeus::Request)
        .to receive(:new)
        .with(
          'http://localhost:8080/v1/endpoint',
          {
            method:  'POST',
            body:    'body',
            headers: {
              'User-Agent' => "Bitstamp::Client Ruby v#{::Bitstamp::VERSION}"
            },
            connecttimeout: 1,
            timeout:        10
          }
        ).and_return(request)

      expect(request)
        .to receive(:run)
        .and_return(response)

      expect(described_class)
        .to receive(:handle_body)
        .with('{"name" : "paul"}')
        .and_call_original

      expect(
        described_class.call(
          'http://localhost:8080/v1/endpoint',
          'POST',
          'body'
        )
      ).to eq({ 'name' => 'paul' })
    end
  end

  describe '#request_uri' do
    it 'is delegated to the class method' do
      expect(described_class)
        .to receive(:request_uri)
        .with('parts')
        .and_return('result')

      expect(client.request_uri('parts')).to eq('result')
    end
  end

  describe '#call' do
    it 'is forwarded to the class method' do
      request_uri = 'uri'
      method      = 'POST'
      body        = {}

      expect(described_class)
        .to receive(:call)
        .with(request_uri, method, body)
        .and_return('result')

      expect(client.call(request_uri, method, body)).to eq('result')
    end
  end

  describe '#params_with_signature' do
    it 'adds key, signature and nonce' do
      expect(Time)
        .to receive(:now)
        .and_return(Time.parse('2017-12-12T12:12:12Z'))

      expect(client.params_with_signature({}))
        .to eq({
          nonce:     '1513080732000000',
          key:       api_key,
          signature: 'AC5E50225394FE65E7807EAD42F71751BFB23B4ACEAD536E7B6592A38718D797'
        })
    end

    it 'uses the given nonce' do
      expect(client.params_with_signature({ nonce: '12345' }))
        .to eq({
          nonce:     '12345',
          key:       api_key,
          signature: '5C893B34EE6778F6936D98372CE50375C1B8377778EDD28DCEEE9581B0CEBFE4'
        })
    end
  end

  describe '#build_signature' do
    it 'returns the signature' do
      expect(client.build_signature('abc'))
        .to eq('0F0D41DB7221335099C3987108D93BAD08E4D592063159D9FAC3E813B5392CDB')
    end
  end
end
