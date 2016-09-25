module QuestradeClient
  module Account
    # Retrieves current server time.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/time
    #
    # @return [DateTime] Current server time in ISO format and Eastern time zone.
    # @example
    #   client.time
    def time
       DateTime.parse(get('/time')['time'])
    end

  end
end
