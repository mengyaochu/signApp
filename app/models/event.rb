class Event < ActiveRecord::Base
  validates_presence_of :title, :message => " is required." 
  validates_presence_of :starts_at, :message => " is required."
  validates_presence_of :ends_at, :message => " is required."
  
  attr_accessible :title, :category_id, :event_type_id, :starts_at, :ends_at, :description, :user_id, :related_id, :with, :course_id, :read_only
  
  belongs_to :user, :foreign_key => :user_id
  has_one :category

  paginates_per 6
  
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  scope :user_id, lambda {|user_id| {:conditions => ["user_id = ?", user_id] }}
  scope :not_me, lambda {{:conditions => ["read_only = 0"] }}
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description,
      :start => starts_at - (8 * 3600),
      :end => ends_at - (8 * 3600),
      :allDay => false,
      :recurring => false,
      :textColor => "#000",
      :backgroundColor => if self.event_type_id == 6 || self.event_type_id == 7 || self.event_type_id == 8 then "blue" elsif self.event_type_id == 1 then "red" elsif self.event_type_id == 5 then "yellow" else "green" end,
      :borderColor => if self.event_type_id == 6 || self.event_type_id == 7 || self.event_type_id == 8 then "blue" elsif self.event_type_id == 1 then "red" elsif self.event_type_id == 5 then "yellow" else "green" end
    }
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  def self.search(course_event_ids, title, type, user_id)
    if (title || type)
      if course_event_ids.length == 0 then
        where('title LIKE ? AND event_type_id LIKE ? AND user_id = ?', "%#{title}%", "%#{type}%", user_id)
      else
        where('course_id not in (?) AND title LIKE ? AND event_type_id LIKE ? AND user_id = ?', course_event_ids.map(&:course_id), "%#{title}%", "%#{type}%", user_id)
      end
    else
      if course_event_ids.length == 0 then
        where('user_id = ?', user_id)
      else
        where('course_id not in (?) AND user_id = ?', course_event_ids.map(&:course_id), user_id)
      end
    end
  end
  
end
