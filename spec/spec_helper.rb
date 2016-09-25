require 'simplecov'
SimpleCov.start
require 'questrade_client'
require 'webmock/rspec'
require 'json'

def stub_get(url)
  stub_request(:get, "https://app01.iq.questrade.example.com#{url}")
end

def stub_post(url, data = {})
  stub_request(:post, "https://app01.iq.questrade.example.com#{url}").with(body: JSON.dump(data))
end

def stub_put(url, data = {})
  stub_request(:put, "https://app01.iq.questrade.example.com#{url}").with(body: JSON.dump(data))
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.read(fixture_path + '/' + file)
end

def json_response(file, status = 200)
  {
    status: status,
    body: fixture(file),
    headers: {
      content_type: 'application/json; charset=utf-8'
    }
  }
end
