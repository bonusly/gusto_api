# GustoApi

This gem provides an easy way to talk with the API for [Gusto](https://gusto.com/).

The functionality for this gem is by no means exhaustive. If there's an endpoint
that is unsupported, please feel free to add and open a PR.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gusto_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gusto_api

## Usage

### Configuration

In an initializer, say, `config/initializers/gusto_api.rb`, configure the gem
with settings provided by Gusto:

```ruby
GustoApi.configure do |config|
  config.api_token = 'token'
  config.client_id = 'client id'
  config.client_secret = 'client secret'
  config.redirect_url = 'redirect url'
end
```

### Creating a Company

This requires configuring the API token above with the token provided by Gusto.

Example with the minimum set of attributes:

```ruby
GustoApi::Company.create(
  user: {
    first_name: 'George',
    last_name: 'Hampton,'
    email: 'george@example.com'
  },
  company: {
    name: 'Hampton LLC'
  }
)
```

Returns:

```
{
  "account_claim_url": "https://app.gusto.com/claim_account/3456789"
}
```

Documentation for full list of attributes and possible errors: https://docs.gusto.com/v1/examples/creating-a-company

### Getting a Company's Employees

This and most other endpoints require getting an `access_token` via OAuth.

```ruby
GustoApi::Company.new(id, access_token).employees
```

Documentation for response: https://docs.gusto.com/v1/employees

### Want to interact with a different API endpoint?

GustoApi provides a generic `GustoApi::Request` class with the following initialize signature:

```ruby
def initialize(endpoint:, method:, params: {}, auth_token: GustoApi.configuration.api_token)
```

`method` must be `:get` or `:post`, and the endpoint is everything after "v1/" in the API endpoint URI.

`params` is a hash that will be sent as query params for a GET request or the response's body for a POST.

Calling `submit` on the instance will use HTTParty to send the request and return the response.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bonusly/gusto_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bonusly/gusto_api/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gusto::Api project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bonusly/gusto_api/blob/master/CODE_OF_CONDUCT.md).

## About Bonusly

![Bonusly Logo](https://bonusly-files.s3.amazonaws.com/bonusly-logo.png?small)

Bonusly is the fun and easy way to engage all of your employees and improve retention and productivity at every level of your organization.

Check out [our product](https://bonus.ly) or [our engineering blog](https://engineering.bonus.ly).
