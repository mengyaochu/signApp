class HomeController < ApplicationController
  before_filter :authenticate_user! , :except => [:reset_password , :reset ]
  
  def index
    redirect_path = root_path
    
    user_roll_name = current_user.roles.collect.first[:name]
    
    if user_roll_name == "student" then
      redirect_path = students_index_path
    end
    
    if user_roll_name == "coach" then
      redirect_path = coaches_index_path
    end
    
    if user_roll_name == "admin" || user_roll_name == "owner" then
      redirect_path = admin_root_path
    end
    
    respond_to do |format|
        format.html { redirect_to redirect_path}
        format.xml  { render :xml => @events }
        format.js   { render :json => @events }
    end
  end

  def reset_password
    @new_user = UserInvite.find_by_code(params[:invite_code])
    
    if UserInvite.find_all_by_code(params[:invite])
        if @new_user.activate.eql? true
           flash[:error] = "Your link is expired"
           redirect_to root_path
        else
          @new_user.update_attribute(:activate,  true)
        end
    else
      flash[:error] = "Invalid Link"
      redirect_to root_path
    end

  end

  def reset
    @user = User.find_by_email(params[:user][:email])
    
    if @user.update_attributes(params[:user])
       sign_in @user
       flash[:notice] = "your account is activated."
    else
       flash[:error] = "your account is not activated"
    end
    redirect_to root_path
  end
end
