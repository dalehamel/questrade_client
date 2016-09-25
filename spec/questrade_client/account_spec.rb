require 'spec_helper'

describe QuestradeClient do
  let(:endpoint) { 'https://app01.iq.questrade.example.com' }
  let(:token) { 'TESTTOKEN' }
  let(:client) { QuestradeClient::Client.new(endpoint: endpoint, token: token) }

  describe '#time' do
    it 'gets the current server time' do
      stub_get('/v1/time').to_return(json_response('time.json'))
      expect(client.time).to be_a(DateTime)
      expect(client.time).to eq(DateTime.parse('2014-10-24T12:14:42.730000-04:00'))
    end
  end
end
