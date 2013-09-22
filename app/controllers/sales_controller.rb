class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
    if @sale.agent
      @sale.agent_name = @sale.agent.name
    end
    if @sale.room
      @sale.room_name = @sale.room.room_number + " (#{@sale.room.property.address})"
    end
    if @sale.buyer
      @sale.buyer_name = @sale.buyer.name
    end
    if @sale.broker
      @sale.broker_name = @sale.broker.name
    end
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sale }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end
  
  # PUTS /sales/search
  def search
    @sale = Sale.new(sale_params)
    @sale.agent = createAgent(params[:sale])
    @sale.buyer = Individual.new(individuals_params(params[:sale][:buyer]))
    @sale.broker = Individual.new(individuals_params(params[:sale][:broker]))
    @sale.room = createRoom(params[:sale])
    @sales = @sale.search
    render "index"
  end
  
  # GETS /sales/search
  def search_form
    render "search"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:agent_id, :agent_name, :hear, :buyer_id, :buyer_name, :broker_id, :broker_name, :room_id, :room_name, :closing_date, :company, :office_number)
    end
end
