class CreateCoachesTeams < ActiveRecord::Migration
  def change
    create_table :coaches_teams do |t|
      t.integer :coach_id
      t.integer :team_id

      t.timestamps
    end
  end
end
