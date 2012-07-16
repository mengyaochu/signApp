class CreateCourses < ActiveRecord::Migration
  def change
    create_table(:courses) do |t|
      t.string :title     	
      t.string :term
      t.string :department 
      t.integer:crn
	  t.string :status
	  t.string :subject
	  t.string :sect
	  t.string :credit
	  t.string :instructor
	  t.string :bldg
	  t.string :day
	  
	  t.time :start_time
	  t.time :end_time

      t.date :from
      t.date :to
	  
	  t.string :fee
    end
  end
end
