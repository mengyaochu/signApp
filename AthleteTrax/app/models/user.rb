class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable  

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :roles, :user_invite

  paginates_per 16
  
  has_many :roles_users
  has_many :roles, :through => :roles_users
  has_one  :user_invite
  has_one  :profile
  
  def role_symbols
    @role_symbols ||= (roles || []).map {|r| r.name.to_sym}
  end
  
  #def role?(role)
  #  return !!self.roles.find_by_name(role.to_s)
  #end
end
