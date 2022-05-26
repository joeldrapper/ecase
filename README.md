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

Let's say you're building an API to delete stale records. You have a list of tables that will need to be pruned in one part, but now you need another part of your API to collect a query to use for each table.

What's more, you need these queries to be exhaustive so that whenever a table is added to the list of tables to prune, a new query is also added for that table. Here's how you could do that:

```ruby
module Pruner
  extend self

  def tables_to_prune
    # some definition of tables to prune
  end

  def prune_records(&block)
    @queries = Ecase.new(tables_to_prune, &block)

    @queries.each do |table_name, query|
      ...
    end
  end
end
```

By instanciating an Ecase with an enumerable collection of expected cases, and the block that defines behavior for those cases, we can guarantee each case is covererd. This ecase object can then be enumerated for key/value pairs for each case where the value is a block that can be called or passed elsewhere.


```ruby
Pruner.prune_records do
  on(:users) { User.all.inactive }
  on(:posts) { Post.created_before(1.year.ago) }
end
```

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
