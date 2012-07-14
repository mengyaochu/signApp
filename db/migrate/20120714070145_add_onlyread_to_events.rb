class AddOnlyreadToEvents < ActiveRecord::Migration
  def change
    add_column :events, :read_only, :int, :default => 0
end
