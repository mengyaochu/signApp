class Coaches::EventsController < ApplicationController
  
  before_filter :authenticate_user!
  filter_access_to :all
  
  @@length_per_page = 10
    
  # GET /coaches/events
  # GET /coaches/events.json
  def events_showall
  	session['searchEventTitle'] = params[:searchEventTitle] if params[:searchEventTitle]
    session['searchEventType'] = params[:searchEventType] if params[:searchEventType]
    
    @events = Event.search(session['searchEventTitle'], session['searchEventType'], current_user.id).page(params[:page]) 
    @eventTypeArray = EventType.all()
    
  	respond_to do |format|
    		format.html { render action: "index" }
  	end
  end

  # GET /coaches/events
  def events_index 
    session['searchEventTitle'] = ''; 
    session['searchEventType'] = '';
          
    respond_to do |format|
        format.html { redirect_to events_showall_coaches_events_path}
    end
  end

  # GET /coaches/events_search
  def events_search
    @eventTypeArray = get_event_type_array()
    
    respond_to do |format|
      format.html 
    end
  end
  
  # GET /coaches/events/1
  # GET /coaches/events/1.xml
  def show
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def get_event_type_array()
  	  return Category.find(2).event_types + Category.find(4).event_types
  end
  
  def get_my_students()
    @students = {}
    students_cnt = 0
    @user_team = Coach.find(current_user.id).team
    
    if  @user_team != nil then
        @user_team.students.each do |p|
          tmp_student = {p.id => p.first_name}
          @students = @students.merge(tmp_student)
        end
        tmp_student = {-1 => "All of team"}
        @students = @students.merge(tmp_student)
    end
    
    return @students
  end
  
  # GET /coaches/events/new
  # GET /coaches/events/new.xml
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
  
  # POST /coaches/events
  # POST /coaches/events.xml
  def create
    @event = Event.new(params[:event])
    @event[:user_id] = current_user.id    
    @event[:related_id] = 0
    @event[:with] = 0 if params[:event][:with] == ''
	@event.save
    @my_event_id = @event.id
    
    if (params[:event][:with] == '-1') then
      @MyUsersTeam = Coach.find(current_user[:id]).coaches_team.team.users_team
      @MyUsersTeam.collect do |p|
        @event = Event.new(params[:event])
        @event[:user_id] = p.student_id
        @event[:with] = 0
        @event[:related_id] = @my_event_id
        @event.save
      end
    end
    
    if (params[:event][:with] != '-1' && params[:event][:with] != '') then
      @event = Event.new(params[:event])
      @event[:user_id] = params[:event][:with]
      @event[:with] = 0
      @event[:related_id] = @my_event_id
      @event.save
    end
     
    respond_to do |format|
      format.html { redirect_to(events_showall_coaches_events_path, :notice => 'Event was successfully created.') }
    end
  end
  
  # GET /coaches/events/1/edit
  def edit
    @event = Event.find(params[:id])
    @eventTypeArray = get_event_type_array()
    @studentArray = get_my_students()
    @action_path = "update"
  end
  
  # PUT /coaches/events/1
  # PUT /coaches/events/1.xml
  # PUT /coaches/events/1.js
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
    
    if (params[:event][:with] == '-1') then
      @MyUsersTeam = Coach.find(current_user[:id]).coaches_team.team.users_team
      @MyUsersTeam.collect do |p|
        @event = Event.new(params[:event])
        @event[:user_id] = p.student_id
        @event[:with] = 0
        @event[:related_id] = params[:id]
        @event.save
      end
    end
    
    if (params[:event][:with] != '-1' && params[:event][:with] != '') then
      @event = Event.new(params[:event])
      @event[:user_id] = params[:event][:with]
      @event[:with] = 0
      @event[:related_id] = params[:id]
      @event.save
    end
    
    respond_to do |format|
      format.html { redirect_to(events_showall_coaches_events_path, :notice => 'Event was successfully updated.') }
      format.js { head :ok}
    end
  end

  # DELETE /coaches/events/1
  # DELETE /coaches/events/1.xml
  def destroy
    @event = Event.find(params[:id])
    
    related_events = Event.find(:all, :conditions => [ "related_id = ?",  @event[:id]])
    related_events.each {|e| e.destroy}
    
    @event.destroy
    
    respond_to do |format|
      format.html { redirect_to(events_showall_coaches_events_path, notice: 'Event was successfully deleted.') }
    end
  end
end
