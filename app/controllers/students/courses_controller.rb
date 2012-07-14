class Students::CoursesController < ApplicationController
  
  before_filter :authenticate_user!
  filter_access_to :all
  
  @@length_per_page = 10
  
  # GET /students/courses/courses_showall
  # GET /students/courses/courses_showall.json
  def courses_showall
    session['searchCourseTitle'] = params[:searchCourseTitle] if params[:searchCourseTitle]
    session['searchCourseTerm'] = params[:searchCourseTerm] if params[:searchCourseTerm]
    session['searchCourseCRN'] = params[:searchCourseCRN] if params[:searchCourseCRN]
    session['searchCourseStatus'] = params[:searchCourseStatus] if params[:searchCourseStatus]
    session['searchCourseSubject'] = params[:searchCourseSubject] if params[:searchCourseSubject]
    session['searchCourseInstrutor'] = params[:searchCourseInstrutor] if params[:searchCourseInstrutor]
    session['searchCourseDay'] = params[:searchCourseDay] if params[:searchCourseDay]
    session['searchCourseFrom'] = params[:searchCourseFrom] if params[:searchCourseFrom]
    session['searchCourseTo'] = params[:searchCourseTo] if params[:searchCourseTo]
    session['searchCourseStartTime'] = params[:searchCourseStartTime] if params[:searchCourseStartTime]
    session['startCourseEndTime'] = params[:startCourseEndTime] if params[:startCourseEndTime]
    
    #if params[:showall] != '1' then
    #  @course_event_ids = UsersCourse.where("student_id = ?", current_user.id)  
    #end
    
	  @courses = Course.search(session['searchCourseTitle'], session['searchCourseTerm'], session['searchCourseCRN'], 
    session['searchCourseStatus'], session['searchCourseSubject'], session['searchCourseInstrutor'], session['searchCourseDay'], 
    session['searchCourseFrom'],  session['searchCourseTo'], session['searchCourseStartTime'], session['startCourseEndTime']).page(params[:page]) 
	  
    respond_to do |format|
       format.html { render action: "index" }
       format.json { render json: @courses }
    end
  end
  
  # GET /students/courses/courses_index
  def courses_index
    session['searchCourseTitle'] = ''; 
    session['searchCourseTerm'] = '';
    session['searchCourseCRN'] = '';
    session['searchCourseStatus'] = '';
    session['searchCourseSubject'] = '';
    session['searchCourseInstrutor'] = '';
    session['searchCourseDay'] = '';
    session['searchCourseFrom'] = '';
    session['searchCourseTo'] = '';
    session['searchCourseStartTime'] = '';
    session['startCourseEndTime'] = '';
    
    respond_to do |format|
      format.html { redirect_to courses_showall_students_courses_path}
    end
  end
  
  # GET /students/courses/courses_search
  def courses_search
    @terms = Course.group("term")
    @departments = Course.group("department")
    @status_group = Course.group("status")
    
    respond_to do |format|
      format.html 
    end
  end
  
  # GET /students/courses/:id
  # GET /students/courses/:id.json
  def show
    @course = Course.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /students/courses/new
  # GET /students/courses/new.json
  def new
    @course = Course.new
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end
  
  # POST /students/courses
  # POST /students/courses.json
  def create
    @course = Course.new(params[:course])
	
    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_showall_students_courses_path, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /students/courses/:id/edit
  def edit
    @course = Course.find(params[:id])
    @action_path = "update"
  end
  
  # PUT /students/courses/:id
  # PUT /students/courses/:id.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to courses_showall_students_courses_path, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/courses/:id
  # DELETE /students/courses/:id.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_showall_students_courses_path, notice: 'Course was successfully deleted.'}
      format.json { head :no_content }
    end
  end
  
  def convertDaytoInt(item_day)
    int_arry = []
    tmp_item_day = item_day.split(", ")
    
    for i in (0..tmp_item_day.length - 1)
      case (tmp_item_day[i])
        when 'Mon' then
          int_arry << 1
        when 'Tue' then
          int_arry << 2
        when 'Wed' then
          int_arry << 3
        when 'Thu' then
          int_arry << 4
        when 'Fri' then
          int_arry << 5
      end
    end
    
    return int_arry
  end

  def getDayOfWeek(w_day)
    tmp_w_day = w_day.split("-")
    year = tmp_w_day[0]
    month = tmp_w_day[1]
    day = tmp_w_day[2]
    
    year1_int = year.to_s.slice(0..1).to_i;
    year2_int = year.to_s.slice(2..3).to_i;

    
    if month.to_i <= 2 then
         refined_mm = month.to_i+12;
         refined_dd = day+1;
    else
        refined_mm = month.to_i;
         refined_dd = day
    end
      
    result = ((21*year1_int.to_i/4) + (5*year2_int.to_i/4) + (26*(refined_mm.to_i+1)/10)+ refined_dd.to_i-1)%7
    
    return result; 
  end
  
  def course_assign_check
  
  end
  
  def course_assign
  	@course = Course.find(params[:id])
    
  	if(@course.status == "CANCELLED" or  @course.status == "CLOSED")
      respond_to do |format|
        render json: 'The course must be opened or waitlist.', content_type: 'text/json'
        return
      end
    end
  		
  	if (@course.id) then
  		if (@course.start_time.to_s[10,6].strip == "00:00") then
        respond_to do |format|
          render json: 'This course has not start/end time. You have to add this course maually.', content_type: 'text/json'
          return
        end
  		end
      
  		end_date = Date.parse(@course.to.to_s)
  		if (end_date < Date.today) then
        respond_to do |format|
          render json: 'This course has been finished.'
          return
        end
      end
      
      from_date = Date.today
      to_date = Date.parse(@course.to.to_s)
      item_day = convertDaytoInt(@course.day)
      
      #check confliction with coach's events
      if params[:real_assign] != '1' then
        @confliction_count = 0
        from_date.upto(to_date) do |day|
          isAssign = item_day.select {|s| s == getDayOfWeek(day.to_s)}
          
          if isAssign.length != 0 then
            @course_starts_at = day.to_s + " #{@course.start_time.to_s[10,9]}"
            @course_ends_at = day.to_s + " #{@course.end_time.to_s[10,9]}"
            @coaches_events = Event.where("event_type_id in (?) AND ((DATE(?) BETWEEN starts_at AND ends_at) OR (DATE(?) BETWEEN starts_at AND ends_at))", EventType.where("category_id = 4").map(&:id), @course_starts_at, @course_ends_at)
            @confliction_count = @confliction_count + @coaches_events.length
          end
        end
        if (@coaches_events.length > 0) then
          respond_to do |format|
            render json: "confliction:#{@confliction_count}"
            return
          end
        end
      end
      
  		from_date.upto(to_date) do |day|
        isAssign = item_day.select {|s| s == getDayOfWeek(day.to_s)}
        
        if isAssign.length != 0 then
          @event = Event.new
          @event.title=@course.title
          @event.event_type_id=1
          @event.starts_at=day.to_s + " #{@course.start_time.to_s[10,9]}"
          @event.ends_at=day.to_s + " #{@course.end_time.to_s[10,9]}"
          @event.description="Status: #{@course.status}\nCRN: #{@course.crn}\nSubject: #{@course.subject}\nTerm: #{@course.term}\nDepartment: #{@course.department}\nInstructor: #{@course.instructor}\nBldg: #{@course.bldg}\nFrom: #{@course.from}\nTo: #{@course.to}\nDay: #{@course.day}\nSect: #{@course.sect}\nCredit: #{@course.credit}\nFee: #{@course.fee}"
          @event.user_id=current_user.id
          @event.related_id = 0
          @event.with = 0
          @event.course_id = @course.id
          @event.read_only = 1 
          @event.save
        end
  		end
      
      @user_course = UsersCourse.new({:student_id => current_user.id, :course_id => @course.id})
      @user_course.save
           
      redirect_to courses_showall_students_courses_path(:showall => 1), notice: 'Assign operation is succeed.'
  		return;
  	end 
	
		redirect_to courses_showall_students_courses_path(:showall => 1), notice: 'Assign operation is failed!'
	end
    
	def course_unassign
		@course = Course.find(params[:id])
  
    @events = Event.where("course_id = ? AND user_id = ?", @course.id, current_user.id)
          
  	if @events.destroy_all
      UsersCourse.where("course_id = ? AND student_id = ?", @course.id, current_user.id).first.destroy
      
      redirect_to courses_showall_students_courses_path(:showall => 1), notice: 'Unassign operation is succeed.'
    else        
      redirect_to courses_showall_students_courses_path(:showall => 1), notice: 'Unassign operation is failed!'
    end 
	end
end
