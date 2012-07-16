
class Student < User
  has_one :users_team
  has_one :team, :through => :users_team
  has_many :courses, :through => :users_courses
end
