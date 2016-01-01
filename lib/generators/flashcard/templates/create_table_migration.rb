class <%= @migration_class_name %> < ActiveRecord::Migration
  def change
    create_table :<%= table_name %> do |t|
      t.column :easiness_factor, :float, default: 2.5
      t.column :repetitions, :integer, default: 0
      t.column :interval, :integer, default: 0
      t.column :due, :date, default: nil
      t.column :studied_at, :date, default: nil
    end
  end
end
