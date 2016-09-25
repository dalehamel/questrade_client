require 'spec_helper'

describe QuestradeClient do
  let(:endpoint) { 'https://app01.iq.questrade.example.com' }
  let(:token) { 'TESTTOKEN' }
  let(:account) { '26598145' }
  let(:orderid) { '173577870' }
  let(:client) { QuestradeClient::Client.new(endpoint: endpoint, token: token) }

  describe '#time' do
    it 'gets the current server time' do
      stub_get('/v1/time').to_return(json_response('time.json'))
      expect(client.time).to be_a(DateTime)
      expect(client.time).to eq(DateTime.parse('2014-10-24T12:14:42.730000-04:00'))
    end
  end

  describe '#accounts' do
    it 'returns a list of accounts' do
      stub_get('/v1/accounts').to_return(json_response('accounts.json'))
      expect(client.accounts).to be_a(Array)
      expect(client.accounts.length).to eq(1)
      expect(client.accounts.first['type']).to eq('Margin')
    end
  end

  describe '#positions' do
    it 'returns positions for an account' do
      stub_get("/v1/accounts/#{account}/positions").to_return(json_response('positions.json'))
      expect(client.positions(account)).to be_a(Array)
      expect(client.positions(account).length).to eq(1)
      expect(client.positions(account).first['symbol']).to eq('THI.TO')
      expect(client.positions(account).first['currentPrice']).to eq(60.17)
    end
  end

  describe '#balances' do
    it 'returns the balance data for this account' do
      stub_get("/v1/accounts/#{account}/balances").to_return(json_response('balances.json'))
      expect(client.balances(account)).to be_a(Hash)
      expect(client.balances(account).keys.length).to eq(4)
      expect(client.balances(account)['perCurrencyBalances']).to be_a(Array)
      expect(client.balances(account)['perCurrencyBalances'].length).to eq(2)
      expect(client.balances(account)['perCurrencyBalances'].select {|x| x['currency'] == 'CAD'}.first['cash']).to eq(500000)
    end
  end

  describe '#executions' do
    it 'returns the executions on this account' do
      stub_get("/v1/accounts/#{account}/executions").to_return(json_response('executions.json'))
      expect(client.executions(account)).to be_a(Array)
      expect(client.executions(account).length).to eq(1)
      expect(client.executions(account).first['symbol']).to eq('AAPL')
      expect(client.executions(account).first['side']).to eq('Buy')
      expect(client.executions(account).first['venue']).to eq('LAMP')

    end
  end

  describe '#orders' do
    it 'returns all orders placed in this account' do
      stub_get("/v1/accounts/#{account}/orders").to_return(json_response('orders.json'))
      expect(client.orders(account)).to be_a(Array)
      expect(client.orders(account).length).to eq(1)
      expect(client.orders(account).first['symbol']).to eq('AAPL')
      expect(client.orders(account).first['side']).to eq('Buy')
      expect(client.orders(account).first['type']).to eq('Limit')
      expect(client.orders(account).first['exchangeOrderId']).to eq('XS173577870')
    end
  end

  describe '#orders' do
    it 'returns a specific order in the account' do
      stub_get("/v1/accounts/#{account}/orders/#{orderid}").to_return(json_response('orders.json'))
      expect(client.orders(account, orderid)).to be_a(Array)
      expect(client.orders(account, orderid).length).to eq(1)
      expect(client.orders(account, orderid).first['symbol']).to eq('AAPL')
      expect(client.orders(account, orderid).first['side']).to eq('Buy')
      expect(client.orders(account, orderid).first['type']).to eq('Limit')
      expect(client.orders(account, orderid).first['exchangeOrderId']).to eq('XS173577870')
    end
  end

  describe '#activities' do
    it 'returns activities associated with the account' do
      stub_get("/v1/accounts/#{account}/activities").to_return(json_response('activities.json'))
      expect(client.activities(account)).to be_a(Array)
      expect(client.activities(account).length).to eq(1)
    end
  end


end
