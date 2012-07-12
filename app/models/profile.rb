class Profile < ActiveRecord::Base
    attr_accessible :mobile_number, :landline_number, :website, :review, :information, :user_id
    
    belongs_to :user
end
