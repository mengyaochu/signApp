class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text          :information
      t.text          :reviews
      t.string        :email
      t.integer       :mobile_number
      t.string        :landline_number
      t.string        :website
	  t.integer       :user_id
	  
      t.timestamps
    end
  end
end
