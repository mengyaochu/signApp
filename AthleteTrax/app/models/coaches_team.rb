class CoachesTeam < ActiveRecord::Base
  #attr_accessible :coach_id, :team_id

  belongs_to :coach
  belongs_to :team
end
