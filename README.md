# Ecase

Ecase allows you to write exhaustive case statements that ensure all cases are covered.

### Basic usage
You can use an `ecase` pretty much the same way you'd use a normal `case` statement. The difference is you must pass an Enumerable list of expected cases that must be covered by the statement.

Let's say you have a class `Car` with an attribute `color` that corresponds to the name of the paint: `:red`, `:green` or `blue`. You want to define a method `color_hex` that returns the correct HEX code for the color. By using an ecase, you can guarantee the statement has a definition for each possible color.

```ruby
class Car
  VALID_COLORS = [:red, :green, :blue]

  attr_reader :color

  def color_hex
    ecase paint, VALID_COLORS do
      on(:red) { "#ff0000" }
      on(:green) { "#00ff00" }
      on(:blue) { "#0000ff" }
    end
  end
end
```

If we add `:green` to the list of `VALID_COLORS`, the ecase will raise an `Ecase::Error` complaining that we missed a case. It can do this because we passed in a list of expected cases.

### LiteralEnums
If you're using ecases with the `literal_enums` gem, you can pass the enum type as the second argument, since enums are Enumerable.

```ruby
class Message < Enum
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
You can also use an Ecase as part of your own API to demand a case definition.

```ruby
def some_method(&block)
  Enum.new(list_of_things_that_must_be_defined, &block)
end
```

You can also return an Ecase instance which is Enumerable, yielding a `condition` and `block`.

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
