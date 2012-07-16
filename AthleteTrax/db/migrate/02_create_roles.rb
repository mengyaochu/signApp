class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
    end
    
    execute "INSERT INTO `roles` VALUES ('1', 'owner');"
	execute "INSERT INTO `roles` VALUES ('2', 'admin');"
	execute "INSERT INTO `roles` VALUES ('3', 'coach');"
	execute "INSERT INTO `roles` VALUES ('4', 'student');"

  end
end
