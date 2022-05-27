# Ecase

Ecase allows you to write exhaustive case statements that ensure all possible cases are covered.

## Usage

### Basic usage
You can use an `ecase` pretty much the same way you'd use a normal `case` statement. The difference is you must pass a list of required cases to be covered by the statement as the second argument. This can be any enumerable.

```ruby
ecase greeting, [1, 2, 3] do
  on(1) { "Hello" }
  on(2, 3) { "Goodbye" }
end
```

### With literal enums
If you're using ecases with the `literal_enums` gem, you can pass the enum type as the second argument, since this is enumerable.

```ruby
class Message
  Greeting()
  Farewell()
end

def say(message)
  ecase message, Message do
    on(Greeting) { "Hello, nice to meet you." }
    on(Farewell) { "Goodbye 👋" }
  end
end
```

### Advanced usage
You can also use an Ecase as part of your own Ruby API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ecase'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ecase

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ecase. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ecase/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ecase project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ecase/blob/master/CODE_OF_CONDUCT.md).
