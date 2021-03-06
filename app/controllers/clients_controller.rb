class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    if @client.individual
      @client.individual_name = @client.individual.name
    end
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render action: 'show', status: :created, location: @client }
      else
        format.html { render action: 'new' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
  
  # PUTS /clients/search
  def search
    @client = createClient(params)
    @clients = @client.search
    render "index"
  end
  
  # GETS /clients/search
  def search_form
    render "search"
  end
  
  def auto_clients
    if params[:term] && (params[:term].length > 2)
      users = Client.search_by_name(params[:term])
    else
      users = Client.all
    end
    list = users.map {|u| Hash[id: u.id, label: u.name + " (" + u.company + ")", name: u.name]}
    respond_to do |format|
      format.json { render json: list }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:comments, :file_number, :source, :company, :date_received, :confirmed, :comments, :individual_id, :individual_name)
    end
    
    def individual_params
      params[:client][:individual].permit(:fname, :lname, :phone, :street_1, :street_2, :city, :state, :zip, :email)
    end
end
