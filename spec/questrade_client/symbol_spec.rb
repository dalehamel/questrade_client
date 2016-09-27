require 'spec_helper'

describe QuestradeClient::Symbol do
  let(:endpoint) { 'https://app01.iq.questrade.example.com' }
  let(:token) { 'TESTTOKEN' }
  let(:symbol) { 'AAPL' }
  let(:symbolid) { 8049 }
  let(:symbols) { [ 'AAPL', 'SHOP', 'VTI' ] }
  let(:symbolids) { [ 8049, 9975422, 40571 ] }
  let(:optionid) { 9292 }
  let(:client) { QuestradeClient::Client.new(endpoint: endpoint, token: token) }

  describe '#symbols' do
    it 'gets a single symbol' do
      stub_get("/v1/symbols/#{symbolid}").to_return(json_response('symbol.json'))
      expect(client.symbols(symbolid)).to be_a(Array)
      expect(client.symbols(symbolid).length).to eq(1)
      expect(client.symbols(symbolid).first['symbol']).to eq('AAPL')
      expect(client.symbols(symbolid).first['symbolId']).to eq(8049)
      expect(client.symbols(symbolid).first['description']).to eq('APPLE INC')
    end

    it 'gets multiple symbols by name' do
      stub_get("/v1/symbols?names=#{symbols.join(',')}").to_return(json_response('symbols.json'))
      expect(client.symbols(symbols)).to be_a(Array)
      expect(client.symbols(symbols).length).to eq(3)
      expect(client.symbols(symbols).first['symbol']).to eq('AAPL')
      expect(client.symbols(symbols).first['symbolId']).to eq(8049)
      expect(client.symbols(symbols).first['description']).to eq('APPLE INC')
    end

    it 'gets multiple symbols by id' do
      stub_get("/v1/symbols?ids=#{symbolids.join(',')}").to_return(json_response('symbols.json'))
      expect(client.symbols(symbolids)).to be_a(Array)
      expect(client.symbols(symbolids).length).to eq(3)
      expect(client.symbols(symbolids).first['symbol']).to eq('AAPL')
      expect(client.symbols(symbolids).first['symbolId']).to eq(8049)
      expect(client.symbols(symbolids).first['description']).to eq('APPLE INC')
    end
  end

  describe '#symbolsearch' do
    it 'finds symbols by prefix' do
      stub_get("/v1/symbols/search?prefix=BMO").to_return(json_response('symbolsearch.json'))
      expect(client.symbolsearch('BMO')).to be_a(Array)
      expect(client.symbolsearch('BMO').length).to eq(20)
      expect(client.symbolsearch('BMO').last['symbol']).to eq('BMLWF')
      expect(client.symbolsearch('BMO').last['symbolId']).to eq(12363100)
      expect(client.symbolsearch('BMO').last['description']).to eq('BMO LOW VOLATILITY US EQUITY ETF')
    end
  end

  describe '#symboloptions' do
    it 'shows options for a symbol by id' do
      stub_get("/v1/symbols/#{optionid}/options").to_return(json_response('symboloptions.json'))
      expect(client.symboloptions(optionid)).to be_a(Array)
      expect(client.symboloptions(optionid).length).to eq(4)
      expect(client.symboloptions(optionid).first['chainPerRoot'].first['optionRoot']).to eq('BMO')
      expect(client.symboloptions(optionid).first['listingExchange']).to eq('OPRA')
      expect(client.symboloptions(optionid).first['description']).to eq('BANK OF MONTREAL')
    end
  end
end
