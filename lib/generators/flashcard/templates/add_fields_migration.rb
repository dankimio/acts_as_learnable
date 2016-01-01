class <%= @migration_class_name %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>, :easiness_factor, :float,   default: 2.5
    add_column :<%= table_name %>, :repetitions, :integer, default: 0
    add_column :<%= table_name %>, :interval, :integer, default: 0
    add_column :<%= table_name %>, :due, :date, default: nil
    add_column :<%= table_name %>, :studied_at, :date, default: nil
  end
end
