class Admin::TeamsController < ApplicationController
  
  before_filter :authenticate_user!
  filter_access_to :all

  def index
    @teams = Team.all
  end

  #GET    /admin/admin/teams/:id
  def show
    @team = Team.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  #GET    /admin/teams/new
  def new
    @team = Team.new
    @coachRoleArray = RolesUser.where("role_id = 3")
    @studentRoleArray = RolesUser.where("role_id = 4")
    @coach_select = 1
    @students_select = {}
  end

  #POST   /admin/teams
  def create
    @team = Team.new(params[:team])
    
    @coach = Coach.find(params[:coach][:coach])
    if @coach.team != nil then
      redirect_to new_admin_team_path, notice: "Coach '#{@coach.last_name}' already has '#{@coach.team.name}' team"
      return
    end
    
    if (params[:students][:students].length == 1) then
      redirect_to new_admin_team_path, notice: "Please select the students."
      return
    end
    
    params[:students][:students].each do |student|
      if student != '' then
        @student = Student.find(student)
        
        if (@student.team != nil) then 
          redirect_to new_admin_team_path, notice: "Student '#{@student.last_name}' already has '#{@student.team.name}' team"
          return
        end
      end
    end
    
    respond_to do |format|
      if @team.save
        @coach_team = CoachesTeam.new({:coach_id => params[:coach][:coach], :team_id => @team.id})
        @coach_team.save
        
        params[:students][:students].each do |student|
          if student != '' then
            @user_team = UsersTeam.new({:student_id => student, :team_id => @team.id})
            @user_team.save
          end
        end
        
        format.html { redirect_to admin_teams_path, notice: 'Team was successfully created.' }
      else
        format.html {redirect_to "new" , notice: 'Team creation is failed.' }
      end
    end
  end
 
  #GET    /teams/:id/edit
  def edit
    @team = Team.find(params[:id])
    @coachRoleArray = RolesUser.where("role_id = 3")
    @studentRoleArray = RolesUser.where("role_id = 4")
    @coach_select = @team.coach.id
    @students_select = @team.students
  end

  #PUT    /admin/teams/:id
  def update
    @team = Team.find(params[:id])
    
    @coach = Coach.find(params[:coach][:coach])
    if (@coach.team != nil) && (@coach.team.id != @team.id) then
      redirect_to edit_admin_team_path, notice: "Coach '#{@coach.last_name}' already has '#{@coach.team.name}' team"
      return
    end
    
    params[:students][:students].each do |student|
      if student != '' then
        @student = Student.find(student)
        
        if (@student.team != nil && @student.team.id != @team.id) then 
          redirect_to edit_admin_team_path, notice: "Student '#{@student.last_name}' already has '#{@student.team.name}' team"
          return
        end
      end
    end
    
    respond_to do |format|
      if @team.update_attributes(params[:team])
        CoachesTeam.where("team_id = ?", @team.id).first.destroy
        @coach_team = CoachesTeam.new({:coach_id => params[:coach][:coach], :team_id => @team.id})
        @coach_team.save
        
        UsersTeam.where("team_id = ?", @team.id).each do |user_team|
          user_team.destroy
        end
        
        params[:students][:students].each do |student|
          if student != '' then
            @user_team = UsersTeam.new({:student_id => student, :team_id => @team.id})
            @user_team.save
          end
        end
        
        format.html { redirect_to admin_teams_path, notice: 'Team was successfully updated.' }
      else
        format.html { redirect_to action: "edit", notice: 'Team update is failed.' }
      end
    end
  end

  #DELETE /admin/teams/:id
  def destroy
	  @team = Team.find(params[:id])
    CoachesTeam.where("team_id = ?", params[:id]).first.destroy
    @student_array = UsersTeam.where("team_id = ?", params[:id])
    @student_array.each do |student|
      student.destroy
    end
    
    @team.destroy

    respond_to do |format|
      format.html { redirect_to admin_teams_path, notice: 'Team was successfully deleted.' }
    end
  end
end