class Users::RegistrationsController < Devise::RegistrationsController

 def new
   super
 end

  def create
    params
    super
    RolesUser.create(:role_id => Role.find_by_name('student').id, :user_id => @user.id )
  end

  def update
     super
  end
end