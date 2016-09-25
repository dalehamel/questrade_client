require 'ostruct'
class JSONSerialized < OpenStruct
end

module QuestradeClient
  class Questrade

    def initialize(refresh_token, practice = false)
      @client = QuestradeClient.login(refresh_token, practice)
    end

    def accounts
      @client.accounts.map do |account_data|
        Account.new(account_data)
      end
    end

    class Account < JSONSerialized
    end
  end
end
