class CalendarController < ApplicationController

  before_filter :authenticate_user!
  filter_access_to :all
  
  # GET /calendar
  # GET /calendar.json
  def index
    redirect_path = "root"
    #user_roll_name = current_user.roles.first[:name]
    
    #if user_roll_name == "student" then
    #  redirect_path = calendar_index_path
    #end
    #if user_roll_name == "coach" then
    #  redirect_path = calendar_index_path
    #end
    session['calendarUser'] = params[:calendar_user_id] if params[:calendar_user_id]
    
    @events = Event.scoped  
    @events = @events.after(params['start']) if (params['start'])
    @events = @events.before(params['end']) if (params['end'])
    @events = @events.user_id(session['calendarUser'])
    if session['calendarUser'].to_i != current_user.id
      @events = @events.not_me()
    end
    
    respond_to do |format|
      format.html
      format.js  { render :json => @events }
    end
  end

  # GET /calendar/new
  # GET /calendar/new.json
  def new
    redirect_path = "root"
    user_roll_name = current_user.roles.first[:name]
    
    if user_roll_name == "student" then
      redirect_path = new_students_event_path(:starts_at => params[:starts_at], :ends_at => params[:ends_at])
    end
    if user_roll_name == "coach" then
      redirect_path = new_coaches_event_path(:starts_at => params[:starts_at], :ends_at => params[:ends_at])
    end
    
    respond_to do |format|
      format.html { redirect_to redirect_path}
    end
  end

  # GET /calendar/events/1
  def show
    redirect_path = "root"
    user_roll_name = current_user.roles.first[:name]
    
    if user_roll_name == "student" then
      redirect_path = "/gwu/students/events/#{params[:id]}"
    end
    if user_roll_name == "coach" then
      redirect_path = "/gwu/coaches/events/#{params[:id]}"
    end
    
    respond_to do |format|
      format.html { redirect_to redirect_path}
    end
  end
  
  # PUT /calendar/events/1
  def update
    redirect_path = "root"
    user_roll_name = current_user.roles.first[:name]
    
    if user_roll_name == "student" then
      redirect_path = "/gwu/students/events/#{params[:id]}?calendar_update=1"
    end
    if user_roll_name == "coach" then
      redirect_path = "/gwu/coaches/events/#{params[:id]}?calendar_update=1"
    end
    
    respond_to do |format|
      format.js { redirect_to redirect_path}
    end
  end
end
