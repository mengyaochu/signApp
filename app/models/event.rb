class Event < ActiveRecord::Base
  validates_presence_of :title, :message => " is required." 
  validates_presence_of :starts_at, :message => " is required."
  validates_presence_of :ends_at, :message => " is required."
  
  attr_accessible :title, :category_id, :event_type_id, :starts_at, :ends_at, :description, :user_id, :related_id, :with
  
  belongs_to :user, :foreign_key => :user_id
  has_one :category

  paginates_per 6
  
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  scope :user_id, lambda {|user_id| {:conditions => ["user_id = ?", user_id] }}
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => starts_at.rfc822,
      :end => ends_at.rfc822,
      :allDay => false,
      :recurring => false,
    }
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  
  def self.search(title, type, user_id)
    if (title || type)
      	where('title LIKE ? AND event_type_id LIKE ? AND user_id = ?', "%#{title}%", "%#{type}%", user_id)
    else
      	where('user_id = ?', user_id)
    end
  end
  
end
