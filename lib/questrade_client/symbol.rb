module QuestradeClient
  module Symbol

    # Retrieves the accounts associated with the user on behalf of which the API client is authorized.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/account-calls/accounts
    #
    # @return [Array[Hash]] List of symbol data
    # @param args [Int|Array[Int|String]] The ID of the symbol, or a list of symbol ids or names
    # @example
    #   client.symbols(9292)
    #   client.symbols(['BMO', 'SHOP', 'VTI'])
    #   client.symbols([9292, 8089])
    def symbols(args)
      if args.is_a?(Integer)
        get("/symbols/#{args}")['symbols']
      elsif args.length > 1 && args.first.is_a?(String)
        get("/symbols?names=#{args.join(',')}")['symbols']
      elsif args.length > 1 && args.first.is_a?(Integer)
        get("/symbols?ids=#{args.join(',')}")['symbols']
      else
        fail "Malformed argument: #{args}"
      end
    end

    # Retrieves symbol(s) using several search criteria.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/symbols-search
    #
    # @return [Array[Hash]] List of symbol data
    # FIXME: add offset
    # @param prefix [String] Prefix to use in search
    # @example
    #   client.symbolsearch('BMO')
    def symbolsearch(prefix, offset=nil)
        get("/symbols/search?prefix=#{prefix}")['symbols']
    end

    # Retrieves an option chain for a particular underlying symbol.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/symbols-id-options
    #
    # @return [Array[Hash]] List of option chain data for symbol
    # @param  [Integer] Symbol id to find options for
    # @example
    #   client.symboloptions(9292)
    def symboloptions(symbolid)
        get("/symbols/#{symbolid}/options")['optionChain']
    end


  end
end
