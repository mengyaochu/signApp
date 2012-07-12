class CreateUsersTeams < ActiveRecord::Migration
  def change
    create_table :users_teams do |t|
      t.integer :student_id
      t.integer :team_id

      t.timestamps
    end
  end
end
