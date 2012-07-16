class CreateUserInvites < ActiveRecord::Migration
  def change
    create_table :user_invites do |t|
      t.integer   :user_id
      t.string    :code
      t.boolean   :activate
      t.timestamps
    end
  end
end
