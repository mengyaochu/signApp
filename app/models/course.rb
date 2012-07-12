class Course < ActiveRecord::Base
  
  attr_accessible :title, :term, :department, :crn, :status,  :subject, :sect, :course, :credit, :instructor, :bldg, :day, :start_time, :end_time, :from, :to, :fee
  
  validates_uniqueness_of :crn, :message => " is already exists"
  validates_presence_of :crn, :message => " is required." 
  validates_presence_of :title, :message => " is required." 
  validates_numericality_of :crn, :message => " is a numerical field."
  
  has_many :students, :through => :users_courses
  
  paginates_per 10
  
  def self.search(title, term, crn, status, subject, instructor, c_day, c_from, c_to, starts_at, ends_at)
     if (title || term || crn || status || subject || instructor || c_day || c_from || starts_at || ends_at)
        query_sql = 'title LIKE ? AND term LIKE ? AND crn LIKE ? AND status LIKE ? AND subject LIKE ? AND instructor LIKE ? AND day LIKE ?'
        #if(c_from != '')
        #  query_sql = query_sql + 'AND (from > date(c_from) OR to < date(c_from))'
        #end
        
        where(query_sql, 
        "%#{title}%", "%#{term}%", "%#{crn}%", "%#{status}%", "%#{subject}%", "%#{instructor}%", "%#{c_day}%")
        
     else
        scoped
     end
   end
   
end
