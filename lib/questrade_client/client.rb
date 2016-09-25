require 'questrade_client/account'
require 'faraday_middleware'

module QuestradeClient

  def self.login(refresh_token, practice = false)
    url = if practice
      "https://practicelogin.questrade.com/oauth2/"
    else
      "https://login.questrade.com/oauth2/"
    end

    conn = Faraday.new @endpoint do |f|
        f.headers[:user_agent] = QuestradeClient::USER_AGENT
        f.headers['Content-length'] = '0'
        f.response :json, content_type: /\bjson$/
        f.adapter Faraday.default_adapter
      end
    endpoint = "#{url}token?grant_type=refresh_token&refresh_token=#{refresh_token}"
    r = conn.send(:post, endpoint)

    if r.success?
#      puts "New refresh token: #{r.body['refresh_token']}"
      endpoint = r.body['api_server']
      token = r.body['access_token']
      return Client.new(endpoint: endpoint, token: token)
    else
#      puts "Login failed!"
#      puts r.body
      return nil
    end
  end

  class Client
    attr_reader :endpoint, :token

    def initialize(options = {})
      @endpoint = options[:endpoint].to_s
      @token = options[:token].to_s
      raise ArgumentError, ":endpoint can't be blank" if @endpoint.empty?
      raise ArgumentError, ":token can't be blank" if @token.empty?
    end

    include QuestradeClient::Account

    private

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, data = {})
      request(:post, path, data)
    end

    def put(path, data = {})
      request(:put, path, data)
    end

    def request(method, path, data = {})
      res = connection.send(method, "v1/#{path}", data)
      if res.success? && !res.body.nil? && !res.body.empty? && res.body != ' '
        res.body
      else
        res
      end
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new @endpoint do |f|
        f.request :json
        f.headers[:user_agent] = QuestradeClient::USER_AGENT
        f.headers['Authorization'] = "Bearer #{@token}"

        # f.response :logger
        f.response :mashify
        f.response :json, content_type: /\bjson$/

        f.adapter Faraday.default_adapter
      end
    end
  end
end
