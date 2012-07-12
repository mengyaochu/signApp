class CreateUsersCourses < ActiveRecord::Migration
  def change
    create_table (:users_courses) do |t|
      t.string :student_id
      t.string :course_id
    end
  end
end
