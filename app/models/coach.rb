
class Coach < User
  has_one :coaches_team
  has_one :team, :through => :coaches_team
  
end
