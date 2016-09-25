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

    # Retrieves the accounts associated with the user on behalf of which the API client is authorized.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts
    #
    # @return [Array[Hash]] List of accounts
    # @example
    #   client.accounts
    def accounts
      get('/accounts')['accounts']
    end

    # Retrieves positions in a specified account.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts-id-positions
    #
    # @return [Array[Hash]] List of positions for the account
    # @param id [String] The ID of the account
    # @example
    #   client.positions(id)
    def positions(id)
      get("/accounts/#{id}/positions")['positions']
    end

    # Retrieves per-currency and combined balances for a specified account.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts-id-balances
    #
    # @return [Hash] Balance data for this account
    # @param id [String] The ID of the account
    # @example
    #   client.balances(id)
    def balances(id)
      get("/accounts/#{id}/balances")
    end

    # Retrieves executions for a specific account.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts-id-executions
    #
    # FIXME: Add support for start and end time
    # @return [Array[Hash]] List of executions
    # @param id [String] The ID of the account
    # @example
    #   client.executions(id)
    def executions(id)
      get("/accounts/#{id}/executions")['executions']
    end

    # Retrieves orders for specified account
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts-id-orders
    #
    # FIXME: Add support for start and end time
    # FIXME: Add support for statefilter
    # @return [Array[Hash]] List of orders
    # @param id [String] The ID of the account
    # @param orderid [String] Only retrieve the order matching the specified order ID (optional)
    # @example
    #   client.orders(id)
    def orders(id, orderid = nil)
      get("/accounts/#{id}/orders#{orderid ? "/#{orderid}" : ''}")['orders']
    end

    # Retrieve account activities, including cash transactions, dividends, trades, etc.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts-id-activities
    #
    # FIXME: Add support for start and end time
    # @return [Array[Hash]] List of orders
    # @param id [String] The ID of the account
    # @param orderid [String] Only retrieve the order matching the specified order ID (optional)
    # @example
    #   client.activities(id)
    def activities(id)
      get("/accounts/#{id}/activities")['activities']
    end

  end
end
