# ActsAsLearnable

ActsAsLearnable is a Ruby gem for ActiveRecord models. It provides a simple way to create flashcards in your app. It automatically schedules flashcards for review depending on recall quality (1 to 5). You can easily create a Spaced Repetition System (SRS) using this gem. Flashcards are scheduled using SuperMemo 2 algorithm.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_learnable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_learnable

Create and run migrations (will add flashcard fields if table already exists):

    $ rails generate flashcard MODEL
    $ rake db:migrate

## Usage

Within your model call `acts_as_learnable` method:

```ruby
class Flashcard < ActiveRecord::Base
  acts_as_learnable
end
```

It will automatically extend your class with all necessary methods.

Then you can review flashcards:

```ruby
card = Flashcard.create
card.review(4)   # => Recall quality from 1 (bad) to 5 (perfect)
card.due_today?  # => false
card.due         # => 2015-03-11
card.studied_at  # => 2015-03-10
card.interval    # => 1
card.repetitions # => 1
```

## Contributing

1. Fork it ( https://github.com/itsdan/acts_as_learnable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
