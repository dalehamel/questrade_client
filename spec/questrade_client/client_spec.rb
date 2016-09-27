require 'spec_helper'

describe QuestradeClient do

  let (:faketoken) { 'foobar' }
  let (:practicelogin) { 'https://practicelogin.questrade.com/oauth2/token?grant_type=refresh_token' }
  let (:headers) { {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Length'=>'0', 'User-Agent'=>"questrade_client/#{QuestradeClient::VERSION}"} }

  describe '#login' do
    it 'can return a client' do
      stub_request(:post, "#{practicelogin}&refresh_token=#{faketoken}")
        .with(
          headers: headers
        )
        .to_return(
          json_response('login.json'),
        )
      client = QuestradeClient.login(faketoken, true)
      expect(client).to_not be(nil)
      expect(client.endpoint).to eq('https://api08.iq.questrade.com/')
      expect(client.token).to eq('rTQDBHZGAGZm61Vq0T6I3WzUH2L94vxR0')
    end

    it 'gracefully fails login' do
      stub_request(:post, "#{practicelogin}&refresh_token=#{faketoken}")
        .with(
          headers: headers
        )
        .to_return(
          status: 400,
          body: 'Bad Request'
        )
      client = QuestradeClient.login(faketoken, true)
      expect(client).to be(nil)
    end

  end
end
