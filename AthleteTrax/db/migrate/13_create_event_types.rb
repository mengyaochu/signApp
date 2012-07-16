class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table(:event_types) do |t|
      t.string :name
      t.integer:category_id
    end
    
    execute "INSERT INTO `event_types` VALUES ('1', 'academics', '1');"
	execute "INSERT INTO `event_types` VALUES ('2', 'homework', '3');"
	execute "INSERT INTO `event_types` VALUES ('3', 'club', '3');"
	execute "INSERT INTO `event_types` VALUES ('4', 'sport', '3');"
	execute "INSERT INTO `event_types` VALUES ('5', 'meeting', '2');"
	execute "INSERT INTO `event_types` VALUES ('6', 'practice', '4');"
	execute "INSERT INTO `event_types` VALUES ('7', 'workout', '4');"
	execute "INSERT INTO `event_types` VALUES ('8', 'competition ', '4');"
	
  end
end
