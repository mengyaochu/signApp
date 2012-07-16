class UserInvite < ActiveRecord::Base
  attr_accessible :code, :user_id, :activate

  belongs_to :user
end
