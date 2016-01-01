require 'rails/generators'
require 'rails/generators/active_record'

class FlashcardGenerator < ActiveRecord::Generators::Base
  include Rails::Generators::Migration

  desc 'This generator creates a migration file with flashcard fields.'

  source_root File.expand_path('../templates', __FILE__)

  def install_flashcards
    if schema_exists? && File.read("#{destination_root}/db/schema.rb") =~ /create_table \"#{table_name}\"/
      migration_template('add_fields_migration.rb', "db/migrate/add_flashcard_fields_to_#{table_name}.rb")
    else
      migration_template('create_table_migration.rb', "db/migrate/create_#{table_name}.rb")
    end
  end

  private

  def schema_exists?
    File.exist?("#{destination_root}/db/schema.rb")
  end
end
