require 'questrade_client/version'
require 'questrade_client/client'
require 'questrade_client/questrade'

module QuestradeClient
  USER_AGENT = "questrade_client/#{QuestradeClient::VERSION}".freeze
end
