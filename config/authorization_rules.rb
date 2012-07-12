authorization do
  role :guest do
    #has_permission_on :use, :to => :read
  end

  role :student do
  	has_permission_on  :students,  		  :to => [:read]
    has_permission_on  :students_courses, :to => [:read, :course_assign, :course_unassign, :courses_index, :courses_search, :courses_showall]
    has_permission_on  :students_events,  :to => [:manage, :events_showall, :events_index, :events_search]
    has_permission_on  :calendar,  		  :to => [:manage]
  end

  role :coach do
  	has_permission_on  :coaches,  		:to => [:read, :my_team]
    has_permission_on  :coaches_events, :to => [:manage, :events_showall, :events_index, :events_search]
    has_permission_on  :calendar,  		:to => [:manage]
  end

  role :admin do
      has_permission_on  :admin_home,       :to => [:index]
      has_permission_on  :admin_users,      :to => [:read]
      has_permission_on  :admin_teams,      :to => [:read]
  end
  
  role :owner do
      has_permission_on  :admin_home,       :to => [:index]
      has_permission_on  :admin_users,      :to => [:manage]
      has_permission_on  :admin_teams,      :to => [:manage]
      has_permission_on  :students_courses, :to => [:manage, :courses_index, :courses_search, :courses_showall]
  end
end


privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
