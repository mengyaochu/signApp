# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 User.delete_all
 Role.delete_all
 RolesUser.delete_all
 Team.delete_all
 UserTeam.delete_all
 UserInvite.delete_all



 admin = User.create( first_name: 'athletic', last_name: 'admin',  email:  'athletic_admin@exp.com', password: '123456', password_confirmation: '123456' , type: 'Admin' )
 coach = User.create( first_name: 'athlete', last_name: 'coach', email:  'athlete_coach@exp.com', password: '123456', password_confirmation: '123456' , type: 'Coach' )


 student1 = User.create( first_name: 'athlete', last_name: 'student1', email:  'athlete_student1@exp.com', password: '123456', password_confirmation: '123456' , type: 'Student')
 student2 = User.create( first_name: 'athlete', last_name: 'student2', email:  'athlete_student2@exp.com', password: '123456', password_confirmation: '123456' , type: 'Student')
 student3 = User.create( first_name: 'athlete', last_name: 'student3', email:  'athlete_student3@exp.com', password: '123456', password_confirmation: '123456' , type: 'Student')
 student4 = User.create( first_name: 'athlete', last_name: 'student4', email:  'athlete_student4@exp.com', password: '123456', password_confirmation: '123456' , type: 'Student')
 student5 = User.create( first_name: 'athlete', last_name: 'student5', email:  'athlete_student5@exp.com', password: '123456', password_confirmation: '123456' , type: 'Student')



  role1 = Role.create(name: 'admin' )
  role2 = Role.create(name: 'student' )
  role3 = Role.create(name: 'coach' )


  RolesUser.create(role_id: role1.id, user_id: admin.id)
  RolesUser.create(role_id: role3.id, user_id: coach.id)

  RolesUser.create(role_id: role2.id, user_id: student1.id)
  RolesUser.create(role_id: role2.id, user_id: student2.id)
  RolesUser.create(role_id: role2.id, user_id: student3.id)
  RolesUser.create(role_id: role2.id, user_id: student4.id)
  RolesUser.create(role_id: role2.id, user_id: student5.id)




  team1 = Team.create(name: "men's golf" )
  team2 = Team.create(name: "women's basketball" )

  @student1 = Student.find(student1.id)
  @student2 = Student.find(student2.id)
  @student3 = Student.find(student3.id)
  @student4 = Student.find(student4.id)
  @student5 = Student.find(student5.id)



  @user_team1 = UserTeam.create(student_id: @student1.id, team_id: team1.id )
  @user_team2 = UserTeam.create(student_id: @student2.id, team_id: team1.id )
  @user_team3 = UserTeam.create(student_id: @student3.id, team_id: team1.id )
  @user_team4 = UserTeam.create(student_id: @student4.id, team_id: team1.id )



  @coach = Coach.find(coach.id)

  @coach_team1 = CoachTeam.create(coach_id: @coach.id, team_id: team1.id )




  @new_user1 = UserInvite.create(user_id: admin.id,  code:  SecureRandom.hex(10))
  @new_user2 = UserInvite.create(user_id: coach.id,  code:  SecureRandom.hex(10))

  @new_user3 = UserInvite.create(user_id: @student1.id,  code:  SecureRandom.hex(10))
  @new_user4 = UserInvite.create(user_id: @student2.id,  code:  SecureRandom.hex(10))
  @new_user5 = UserInvite.create(user_id: @student3.id,  code:  SecureRandom.hex(10))
  @new_user6 = UserInvite.create(user_id: @student4.id,  code:  SecureRandom.hex(10))
  @new_user7 = UserInvite.create(user_id: @student5.id,  code:  SecureRandom.hex(10))



  @new_user1.update_attribute(:activate,  true)
  @new_user2.update_attribute(:activate,  true)
  @new_user3.update_attribute(:activate,  true)
  @new_user4.update_attribute(:activate,  true)
  @new_user5.update_attribute(:activate,  true)
  @new_user6.update_attribute(:activate,  true)
  @new_user7.update_attribute(:activate,  true)



  #student1 = User.create( first_name: 'athlete', last_name: 'student1', email:  'athlete_student1@exp.com', password: '123456', password_confirmation: '123456' )
  #RolesUser.create(role_id: role2.id, user_id: student1.id)
  #UserTeam.create(user_id: student1.id, team_id: team2.id )
  #@new_user3 = UserInvite.create(user_id: student1.id,  code:  SecureRandom.hex(10))
  #@new_user3.update_attribute(:activate,  true)

  #20.times.each do |i|
  #  if i > 5
  #    student = User.create( first_name: 'athlete', last_name: "student#{i}", email:  "athlete_student#{i}@exp.com", password: '123456', password_confirmation: '123456', type: 'Student' )
  #    RolesUser.create(role_id: role2.id, user_id: student.id)
  #    UserTeam.create(user_id: student.id, team_id: team2.id )
  #    @new_user = UserInvite.create(user_id: student.id,  code:  SecureRandom.hex(10))
  #    @new_user.update_attribute(:activate,  true)
  #  end
  #end




