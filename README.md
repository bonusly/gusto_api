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

### OAuth flow

Details are documented here: https://docs.gusto.com/v1/basics/authentication

You'll have to set up a controller for the OAuth authorization callback. Set `redirect_url` to its URL.

To get the initial URL to trigger the OAuth flow, use

```ruby
GustoApi::Oauth.auth_url
```

Link people to that URL and they'll see an authorization page on Gusto's site. After they accept, they'll be redirected to your `redirect_url` with `params[:code]` set to a temporary code that can be exchanged for an `access_token` and `refresh_token` with:

```ruby
GustoApi::Oauth.get_token(code)
```
This returns a hash:
```ruby
{
  "access_token" => "ju53kDqMS0iPVsOECQF-H0ifxHDFBDTi2BHOopMrW1X",
  "token_type" => "Bearer",
  "expires_in" => 7200,
  "refresh_token" => "64ir0v_ioQMdWin6Dv9poXGW-SI04yQr2oXE67YqgP5",
  "scope" => "public",
  "created_at" => 1610493513
}
```

The temporary code lasts for 10 minutes and the access token lasts for 2 hours.

After the access token expires, you'll need to use the `refresh_token` to get a new one:

```ruby
GustoApi::Oauth.refresh_token(refresh_token)
```

The hash returned is identical to that returned by `get_token`. It will give a new `access_token` and `refresh_token`. Each `refresh_token` can only be used once.

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

### Getting the Current User

To get the authenticated user:

```ruby
GustoApi::CurrentUser.fetch(access_token)
```

This will return a hash:

```ruby
{
  "id" => 7757869449967110,
  "email" => "bonusly+demo@gusto.com",
  "roles" => {
    "payroll_admin" => {
      "companies" => [
        {
          "id" => 7756341740967741,
          "name" => "Bonusly Demo",
          "trade_name" => "",
          "locations" => [
            {
              "id" => 7757727716494058,
              "street_1" => "912 Silver St.",
              "street_2" => "Suite 1966",
              "city" => "San Francisco",
              "state" => "CA",
              "zip" => "94107",
              "country" => "USA",
              "active" => true
            }
          ]
        }
      ]
    }
  }
}

```

### Getting a Company's Employees

This and most other endpoints require getting an `access_token` via OAuth.

```ruby
GustoApi::Company.new(id, access_token).employees
```

Documentation for response: https://docs.gusto.com/v1/employees

### Want to interact with a different API endpoint?

GustoApi provides two generic `Request` classes for interacting with the API.

For API endpoints where you use the API key provided by Gusto, there's `GustoApi::TokenRequest` class with the following initialize signature:

```ruby
def initialize(endpoint:, method:, params: {})
```

`method` must be `:get` or `:post`, and `endpoint` is the URI for the API endpoint starting with "v1/".

`params` is a hash that will be sent as query params for a GET request or the response's body for a POST.

For API endpoints where you use the `access_token` fetched via OAuth, there's `GustoApi::BearerRequest` with the following initialize signature:

```ruby
def initialize(endpoint:, method:, params: {}, auth_token:)
```

The arguments are the same except that it requires passing in the `access_token` as the `auth_token` argument.

Calling `submit` on the request instance will use HTTParty to send the request and return the response.


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
