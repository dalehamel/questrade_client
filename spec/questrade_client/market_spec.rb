require 'spec_helper'

describe QuestradeClient::Market do
  let(:symbolid) { 8049 }
  let(:symbolids) { [ 8049, 9975422, 40571 ] }

  let(:endpoint) { 'https://app01.iq.questrade.example.com' }
  let(:token) { 'TESTTOKEN' }
  let(:client) { QuestradeClient::Client.new(endpoint: endpoint, token: token) }

  describe '#markets' do
    it 'gets data about supported markets' do
      stub_get("/v1/markets").to_return(json_response('markets.json'))
      expect(client.markets).to be_a(Array)
      expect(client.markets.length).to eq(11)
    end
  end

  describe '#quotes' do
    it 'gets quotes for a single symbol' do
      stub_get("/v1/markets/quotes/#{symbolid}").to_return(json_response('singlequote.json'))
      expect(client.quotes(symbolid)).to be_a(Array)
      expect(client.quotes(symbolid).length).to eq(1)
      expect(client.quotes(symbolid).first['symbol']).to eq('AAPL')
    end

    it 'gets quotes for multiple symbols' do
      stub_get("/v1/markets/quotes?ids=#{symbolids.join(',')}").to_return(json_response('multiquotes.json'))
      expect(client.quotes(symbolids)).to be_a(Array)
      expect(client.quotes(symbolids).length).to eq(3)
      expect(client.quotes(symbolids).last['symbol']).to eq('VTI')
    end
  end

  describe '#quotesoptions' do
    # FIXME - implement
  end

  describe '#quotestrategies' do
    # FIXME - implement
  end

  describe '#candles' do
    # FIXME - broken without start and end date
  end

end
