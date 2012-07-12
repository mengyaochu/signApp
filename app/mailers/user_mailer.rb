class UserMailer < ActionMailer::Base
  default from: "test@example.com"

  def invite_email(user)
    @user = user
    @url  = "http://localhost:3000#{reset_password_home_index_path}?invite_code=#{@user.user_invite.code}"
    mail(:to => user.email, :subject => "Admin invited")
  end
end
