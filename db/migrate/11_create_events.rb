class CreateEvents < ActiveRecord::Migration
  def change
    create_table(:events) do |t|
      t.string :title ,   	     	:null => false, :default => ""
      t.integer :event_type_id
      t.datetime :starts_at,        :null => false
      t.datetime :ends_at, 			:null => false
      t.text    :description
      t.integer :user_id,			:null => false
	  t.integer :with,				:null => false, :default => 0
	  t.integer :related_id,		:null => false, :default => 0
	  t.integer :course_id,			:null => false, :default => 0
    end
  end
end
