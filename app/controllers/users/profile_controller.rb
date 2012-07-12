class Users::ProfileController < ApplicationController

  #filter_access_to :all
  
  #GET /users/profile
  def index
    @profile = Profile.where('user_id = ?', current_user.id ).first
    @profile = @profile.nil? ? Profile.new : @profile
    @user = current_user
  end

  #POST /users/profile/create
  def create
    @profile = Profile.new(params[:profile])
    if @profile.save!
       redirect_to '/users/profile', notice: 'profile was successfully created.'
    end
  end

  #POST  /users/profile/update
  def update
    @profile = Profile.find(params[:profile][:id])
    
    if @profile.update_attributes(params[:profile])
      redirect_to '/users/profile', notice: 'Profile was successfully updated.'
    end
  end
  
  def show
    @profile = Profile.where("user_id = ?", params[:user_id]).first
    @profile = @profile.nil? ? Profile.new : @profile
    @user = User.find(params[:user_id])
    @back_path = params[:back_path]
  end
end