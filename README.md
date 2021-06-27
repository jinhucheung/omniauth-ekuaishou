[![Gem Version](https://badge.fury.io/rb/omniauth-ekuaishou.svg)](https://badge.fury.io/rb/omniauth-ekuaishou)
[![Build Status](https://github.com/jinhucheung/omniauth-ekuaishou/actions/workflows/main.yml/badge.svg)](https://github.com/jinhucheung/omniauth-ekuaishou/actions)

# Omniauth Ekuaishou

This is the official OmniAuth strategy for authenticating to Kuaishou Marketing. To use it, you'll need to sign up for an OAuth2 Application ID and Secret on the [Kuaishou Marketing Applications Page](https://developers.e.kuaishou.com/application).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-ekuaishou'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install omniauth-ekuaishou
```

## Usage

`OmniAuth::Strategies::Ekuaishou` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ekuaishou, ENV['EKUAISHOU_APP_ID'], ENV['EKUAISHOU_APP_SECRET']
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jinhucheung/omniauth-ekuaishou.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
