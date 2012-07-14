class CoachesController < ApplicationController
  before_filter :authenticate_user!
  filter_access_to :all
  
  # GET /coaches/index
  # GET /coaches/index.json
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # GET /coaches
  # GET /coaches.json
  def my_team
    @team = Coach.find(current_user.id).team
    
    if @team == nil then
      redirect_to coaches_index_path, notice: 'You have no team.'
      return
    end
    
    respond_to do |format|
      format.html # my_team.html.erb
      format.json { render json: @team }
    end
  end
  
  # GET /coaches/1
  # GET /coaches/1.json
  def show
    @coach = Coach.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coach }
    end
  end

  # GET /coaches/new
  # GET /coaches/new.json
  def new
    @coach = Coach.new
     
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coach }
    end
  end

  # GET /coaches/1/edit
  def edit
    @coach = Coach.find(params[:id])
  end

  # POST /coaches
  # POST /coaches.json
  def create
    @coach = Coach.new(params[:coach])

    respond_to do |format|
      if @coach.save
        format.html { redirect_to @coach, notice: 'Coach was successfully created.' }
        format.json { render json: @coach, status: :created, location: @coach }
      else
        format.html { render action: "new" }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coaches/1
  # PUT /coaches/1.json
  def update
    @coach = Coach.find(params[:id])

    respond_to do |format|
      if @coach.update_attributes(params[:coach])
        format.html { redirect_to @coach, notice: 'Coach was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coaches/1
  # DELETE /coaches/1.json
  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy

    respond_to do |format|
      format.html { redirect_to coaches_url }
      format.json { head :no_content }
    end
  end
end
