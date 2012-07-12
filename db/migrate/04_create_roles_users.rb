class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_table (:roles_users) do |t|
      t.references :role, :user
      
      t.timestamps
    end
    
    execute "INSERT INTO `roles_users` VALUES ('1', '1', '1', '2012-07-11 21:56:25', '2012-07-11 21:56:25');"
  end
end
