class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end
    
    execute "INSERT INTO `categories` VALUES ('1', 'academy');"
	execute "INSERT INTO `categories` VALUES ('2', 'meeting');"
	execute "INSERT INTO `categories` VALUES ('3', 'extracurricular');"
	execute "INSERT INTO `categories` VALUES ('4', 'athletics');"

  end
end
