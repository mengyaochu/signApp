class Team < ActiveRecord::Base
  attr_accessible :name
  
  validates_presence_of :name, :message => " is required." 
  
  has_one  :coaches_team
  has_many :users_teams
  has_one  :coach, :through => :coaches_team
  has_many :students, :through => :users_teams
end
