# ActsAsLearnable

ActsAsLearnable is a Ruby gem for ActiveRecord models. It provides a simple way to create flashcards in your app. It automatically schedules flashcards for review depending on recall quality (1 to 5). You can easily create a Spaced Repetition System (SRS) using this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_learnable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_learnable

## Usage

Within your model call `acts_as_learnable` method:

```ruby
class Flashcard < ActiveRecord::Base
  acts_as_learnable
end
```

It will automatically extend your class with all necessary methods.

Make sure you have the following fields on the model (generators will be added later):

```ruby
ActiveRecord::Schema.define(version: 1) do
  create_table :flashcards do |t|
    t.float :easiness_factor, default: 2.5
    t.integer :repetitions, default: 0
    t.integer :interval, default: 0
    t.date :due, default: nil
    t.date :studied_at, default: nil
  end
end
```

Then you can review items:

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

1. Fork it ( https://github.com/[my-github-username]/acts_as_learnable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## TODO

* Migration generators
* More detailed README
* Other repetition algorithms (Anki)