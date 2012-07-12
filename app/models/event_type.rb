class EventType < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :name, :category_id
  belongs_to :categorys
end
