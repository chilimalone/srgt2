class LeasesController < ApplicationController
  before_action :set_lease, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /leases
  # GET /leases.json
  def index
    @leases = Lease.all
  end

  # GET /leases/1
  # GET /leases/1.json
  def show
  end

  # GET /leases/new
  def new
    @lease = Lease.new
  end

  # GET /leases/1/edit
  def edit
    if @lease.client
      @lease.client_name = @lease.client.name
    end
    if @lease.room
      @lease.room_name = @lease.room.room_number + " (" + @lease.room.property.address + ")"
    end
    if @lease.agent
      @lease.agent_name = @lease.agent.name
    end
  end

  # POST /leases
  # POST /leases.json
  def create
    @lease = Lease.new(lease_params)

    respond_to do |format|
      if @lease.save
        format.html { redirect_to @lease, notice: 'Lease was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lease }
      else
        format.html { render action: 'new' }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leases/1
  # PATCH/PUT /leases/1.json
  def update
    respond_to do |format|
      if @lease.update(lease_params)
        format.html { redirect_to @lease, notice: 'Lease was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leases/1
  # DELETE /leases/1.json
  def destroy
    @lease.destroy
    respond_to do |format|
      format.html { redirect_to leases_url }
      format.json { head :no_content }
    end
  end
  
  # PUTS /leases/search
  def search
    @lease = Lease.new(lease_params)
    @lease.client = createClient(params[:lease])
    @lease.agent = createAgent(params[:lease])
    @lease.room = createRoom(params[:lease])
    @leases = @lease.search
    render "index"
  end
  
  # GETS /leases/search
  def search_form
    render "search"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lease
      @lease = Lease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lease_params
      params.require(:lease).permit(:client_id, :client_name, :rental_amount, :move_out, :date, :move_in, :thank_you_sent, :comments, :agent_id, :agent_name, :referral_amount, :room_id, :room_name)
    end
end
