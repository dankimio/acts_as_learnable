require 'minitest/autorun'
require 'sqlite3'
require 'active_record'
require 'acts_as_learnable'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

def setup_db
  ActiveRecord::Schema.define(version: 1) do
    create_table :flashcards do |t|
      t.float :easiness_factor, default: 2.5
      t.integer :repetitions, default: 0
      t.integer :interval, default: 0
      t.date :due, default: nil
      t.date :studied_at, default: nil
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Flashcard < ActiveRecord::Base
  acts_as_learnable
end
