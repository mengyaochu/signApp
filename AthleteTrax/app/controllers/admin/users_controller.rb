class Admin::UsersController < ApplicationController
  
  before_filter :authenticate_user!
  filter_access_to :all
  
  # GET    /admin/users
  def index
    @users = User.where("id <> 1").page(params[:page]) 
  end

  # GET    /admin/users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET    /admin/users/new
  def new
    @user = User.new
    @roleArray = Role.where("name != 'owner'")
  end
  
  # POST   /admin/users
  def create
    @user = User.new({:email => params[:user][:email], :password => "123456", :password_confirmation => "123456", 
      :last_name => params[:user][:last_name], :first_name => params[:user][:first_name]})
    @roleArray = Role.where("name != 'owner'")
    
    if @user.save
       RolesUser.create(:role_id => params[:role][:role], :user_id => @user.id )
       UserInvite.create(user_id: @user.id,  code:  SecureRandom.hex(10))
       UserMailer.invite_email(@user).deliver
       
       redirect_to admin_users_path, notice: 'User was successfully created and invited'
    else
       redirect_to new_admin_user_path, notice: 'User creation is failed'
    end
  end
  
  #GET    /admin/users/:id/edit
  def edit
    @user = User.find(params[:id])
    @roleArray = Role.where("name != 'owner'")
  end
  
  #PUT    /admin/users/:id
  def update
    @user = User.find(params[:id])
    @user_role = @user.roles.first
    
    if (@user_role.id != params[:role][:role].to_i) then
      if (Coach.find(params[:id]).team != nil ) then
        redirect_to edit_admin_user_path, notice: "This user is a coach of '#{Coach.find(params[:id]).team.name}' Team. So we cannot change role of this user."
        return
      end
      
      if (Student.find(params[:id]).team != nil ) then
        redirect_to edit_admin_user_path, notice: "This user is a member of '#{Student.find(params[:id]).team.name}' Team. So we cannot change role of this user."
        return
      end
    end
    
    if @user.update_attributes(params[:user])
      if (@user_role.id != params[:role][:role].to_i) then
        @roles_user = RolesUser.where("user_id = ?", @user.id).first
        @roles_user.update_attributes({:role_id => params[:role][:role], :user_id => @user.id})
      end
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      redirect_to edit_admin_user_path, notice: 'User update is failed.'
    end
  end

  #DELETE /admin/users/:id
  def destroy
    @user = User.find(params[:id])
    @user_role = @user.roles.first
    
    if (Coach.find(params[:id]).team != nil ) then
      redirect_to admin_users_path, notice: "This user is a coach of '#{Coach.find(params[:id]).team.name}' Team. So we cannot delete this user."
      return
    end
    
    if (Student.find(params[:id]).team != nil ) then
      redirect_to admin_users_path, notice: "This user is a member of '#{Student.find(params[:id]).team.name}' Team. So we cannot delete this user."
      return
    end
    
    RolesUser.where("user_id = ?", @user.id).first.destroy   
    UserInvite.where("user_id = ?", @user.id).first.destroy    
    
    @user.destroy
    
    redirect_to admin_users_path, notice: 'This user is deleted succesfully.'
  end

end
