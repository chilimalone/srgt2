class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
    if @tour.room
      @tour.room_name = @tour.room.room_number + " (#{@tour.room.property.address})"
    end
    if @tour.agent
      @tour.agent_name = @tour.agent.name
    end
    if @tour.client
      @tour.client_name = @tour.client.name
    end
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new(tour_params)

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tour }
      else
        format.html { render action: 'new' }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url }
      format.json { head :no_content }
    end
  end
  
  # PUTS /tours/search
  def search
    @tour = Tour.new(tour_params)
    @tour.agent = createAgent(params[:tour])
    @tour.room = createRoom(params[:tour])
    @tours = @tour.search
    render "index"
  end
  
  # GETS /tours/search
  def search_form
    render "search"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:agent_id, :client_id, :date, :room_id, :room_name, :comments, :dropped_date)
    end
end
