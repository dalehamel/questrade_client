module QuestradeClient
  module Market
    CANDLESTICK_INTERVALS = {
      oneminute: 'OneMinute',           # one candlestick per 1 minute.
      twominutes: 'TwoMinutes',         # one candlestick per 2 minutes.
      threeminutes: 'ThreeMinutes',     # one candlestick per 3 minutes.
      fourminutes: 'FourMinutes',       # one candlestick per 4 minutes.
      fiveminutes: 'FiveMinutes',       # one candlestick per 5 minutes.
      tenminutes: 'TenMinutes',         # one candlestick per 10 minutes.
      fifteenminutes: 'FifteenMinutes', # one candlestick per 15 minutes.
      twentyminutes: 'TwentyMinutes',   # one candlestick per 20 minutes.
      halfhour: 'HalfHour',             # one candlestick per 30 minutes.
      onehour: 'OneHour',               # one candlestick per 1 hour.
      twohours: 'TwoHours',             # one candlestick per 2 hours.
      fourhours: 'FourHours',           # one candlestick per 4 hours.
      oneday: 'OneDay',                 # one candlestick per 1 day.
      oneweek: 'OneWeek',               # one candlestick per 1 week.
      onemonth: 'OneMonth',             # one candlestick per 1 month.
      oneyear: 'OneYear'                # one candlestick per 1 year.
    }

    # Retrieves information about supported markets.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/markets
    #
    # @return [Array[Hash]] List of market data
    # @example
    #   client.markets
    def markets
      get('/markets')['markets']
    end

    # Retrieves a single Level 1 market data quote for one or more symbols.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/markets-quotes-id
    #
    # @return [Array[Hash]] List of market data
    # @param args [Int|Array[Int]] The ID of the symbol, or a list of symbol ids
    # @example
    #   client.quotes(9292)
    #   client.quotes([9292,8081])
    def quotes(args)
      if args.is_a?(Integer)
        get("/markets/quotes/#{args}")['quotes']
      elsif args.is_a?(Array)
        get("/markets/quotes?ids=#{args.join(',')}")['quotes']
      else
        fail "Malformed argument: #{args}"
      end
    end

    # Retrieves a single Level 1 market data quote and Greek data for one or more option symbols.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/markets-quotes-options
    #
    # FIXME - implement (docs are WRONG, it's a POST, not a GET)
    def quoteoptions()
      fail "Not yet implemented"
    end

    # Retrieve a calculated L1 market data quote for a single or many multi-leg strategies
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/markets-quotes-strategies
    #
    # FIXME - implement (docs are WRONG, it's a POST, not a GET)
    def quotestrategies()
      fail "Not yet implemented"
    end


    # Retrieves historical market data in the form of OHLC candlesticks for a specified symbol.
    # This call is limited to returning 2,000 candlesticks in a single response.
    #
    # Docs: http://www.questrade.com/api/documentation/rest-operations/market-calls/markets-candles-id
    #
    # @return [Array[Hash]] List of market data
    # FIXME: REQUIRES start and end time
    # @param id [Integer] the id of the symbol to retrieve candlestick data for
    # @param interval [Symbol] the candlestick interval to use, see allowable values in CANDLESTICK_INTERVALS
    # @example
    #   client.candles(9292, :oneday)
    def candles(id, interval)
      fail "Interval #{interval} is unsupported" unless CANDLESTICK_INTERVALS.includes?(interval)
      get("/markets/candles/#{id}?interval=#{CANDLESTICK_INTERVALS[interval]}")['quotes']
    end
  end
end
