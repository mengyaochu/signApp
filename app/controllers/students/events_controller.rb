class Students::EventsController < ApplicationController
  
  before_filter :authenticate_user!
  filter_access_to :all
  
  @@length_per_page = 10
  
  # GET/POST /students/events
  def events_showall
    session['searchEventTitle'] = params[:searchEventTitle] if params[:searchEventTitle]
    session['searchEventType'] = params[:searchEventType] if params[:searchEventType]
    
    @course_event_ids = UsersCourse.where("student_id = ?", current_user.id)
    
    @events = Event.search(@course_event_ids, session['searchEventTitle'], session['searchEventType'], current_user.id).page(params[:page]) 
    @eventTypeArray = EventType.all()
    
    if @course_event_ids.length != 0 then
      @course_event_ids.each do |course_event| 
        @course = Course.find(course_event.course_id)
        @event = Event.new
        
        @event.id = course_event.course_id
        @event.title=@course.title
        @event.event_type_id=1
        @event.starts_at=@course.start_time
        @event.ends_at=@course.end_time
        @event.description="Status: #{@course.status}\nCRN: #{@course.crn}\nSubject: #{@course.subject}\nTerm: #{@course.term}\nDepartment: #{@course.department}\nInstructor: #{@course.instructor}\nBldg: #{@course.bldg}\nFrom: #{@course.from}\nTo: #{@course.to}\nDay: #{@course.day}\nSect: #{@course.sect}\nCredit: #{@course.credit}\nFee: #{@course.fee}"
        @event.related_id = 0
        @event.course_id = course_event.course_id
        @event.with = 0
        @event.read_only = 1 
        
        @events << @event
      end
    end
    
    respond_to do |format|
        format.html { render action: "index" }
    end
  end
    
  # GET /students/events
  def events_index 
    session['searchEventTitle'] = ''; 
    session['searchEventType'] = '';
    	  	
  	respond_to do |format|
    		format.html { redirect_to events_showall_students_events_path}
  	end
  end

  # GET /students/events/events_search
  def events_search
    @eventTypeArray = EventType.all()
    
    respond_to do |format|
      format.html 
    end
  end
  
  # GET /students/events/1
  # GET /students/events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def get_event_type_array()
  	  return Category.find(1).event_types + Category.find(2).event_types + Category.find(3).event_types
  end
  
  def get_my_students()
    @students = {}
    students_cnt = 0
    @user_team = Student.find(current_user.id).team
    
    if  @user_team != nil then
        @user_team.students.each do |p|
          tmp_student = {p.id => p.first_name}
          @students = @students.merge(tmp_student)
        end
    end
    
    return @students
  end
  
  # GET /students/events/new
  # GET /students/events/new.xml
  def new
    @event = Event.new
    @event[:starts_at] = params[:starts_at]
    @event[:ends_at] = params[:ends_at]
    @eventTypeArray = get_event_type_array()
    @studentArray = get_my_students()
    
    respond_to do |format|
      format.html # new.html.erb 
    end
  end
  
  # POST /students/events
  # POST /students/events.xml
  def create
    @event = Event.new(params[:event])
    @event[:user_id] = current_user.id
    @event[:related_id] = 0
    @event[:with] = 0 if params[:event][:with] == ''
	  @event.save
	  @my_event_id = @event.id
    
    if (params[:event][:with] != '') then
      @event = Event.new(params[:event])
      @event[:user_id] = params[:event][:with]
      @event[:with] = 0
      @event[:related_id] = @my_event_id
      @event.save
    end
    
    respond_to do |format|
      format.html { redirect_to(events_showall_students_events_path, :notice => 'Event was successfully created.') }
    end
  end
  
  # GET /students/events/1/edit
  def edit
    @event = Event.find(params[:id])
    @eventTypeArray = get_event_type_array()
    @studentArray = get_my_students()
    @action_path = "update"
  end
  
  # PUT /students/events/1
  # PUT /students/events/1.xml
  # PUT /students/events/1.js
  def update
    @event = Event.find(params[:id])
    @event[:user_id] = current_user.id
    @eventTypes = get_event_type_array()
    @event[:related_id] = 0
    @event[:with] = 0 if params[:event][:with] == ''
    @event.update_attributes(params[:event])
    
    # remake the related events
    related_events = Event.find(:all, :conditions => [ "related_id = ?",  @event[:id]])
    related_events.each {|e| e.destroy}
    
    if (params[:event][:with] != '') then
      @event = Event.new(params[:event])
      @event[:user_id] = params[:event][:with]
      @event[:with] = 0
      @event[:related_id] = params[:id]
      @event.save
    end
    
    respond_to do |format|
        format.html { redirect_to(events_showall_students_events_path, :notice => 'Event was successfully updated.') }
        format.js { head :ok}
    end
  end

  # DELETE /students/events/1
  # DELETE /students/events/1.xml
  def destroy
    @event = Event.find(params[:id])
    
    related_events = Event.find(:all, :conditions => [ "related_id = ?",  @event[:id]])
    related_events.each {|e| e.destroy}
    
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_showall_students_events_path, notice: 'Event was successfully deleted.') }
    end
  end
end
