# QuestradeClient

Set up a practice account to play around:

http://www.questrade.com/api/free-practice-account

Login with it at:

https://practicelogin.questrade.com/Signin.aspx?ReturnUrl=%2fAPIAccess%2fUserApps.aspx

Register a practice app (give it all permissions, this is a test account)

Generate a new device authorization token, you'll need that! It's considered a "refresh" token. After being used once, it's no more good - you'll get a new refresh token though.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'questrade_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install questrade_client

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/questrade_client.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

