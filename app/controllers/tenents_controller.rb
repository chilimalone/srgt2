class TenentsController < ApplicationController
  before_action :set_tenent, only: [:show, :edit, :update, :destroy]

  # GET /tenents
  # GET /tenents.json
  def index
    @tenents = Tenent.all
  end

  # GET /tenents/1
  # GET /tenents/1.json
  def show
  end

  # GET /tenents/new
  def new
    @tenent = Tenent.new
  end

  # GET /tenents/1/edit
  def edit
  end

  # POST /tenents
  # POST /tenents.json
  def create
    @tenent = Tenent.new(tenent_params)

    respond_to do |format|
      if @tenent.save
        format.html { redirect_to @tenent, notice: 'Tenent was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tenent }
      else
        format.html { render action: 'new' }
        format.json { render json: @tenent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tenents/1
  # PATCH/PUT /tenents/1.json
  def update
    respond_to do |format|
      if @tenent.update(tenent_params)
        format.html { redirect_to @tenent, notice: 'Tenent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tenent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tenents/1
  # DELETE /tenents/1.json
  def destroy
    @tenent.destroy
    respond_to do |format|
      format.html { redirect_to tenents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenent
      @tenent = Tenent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tenent_params
      params.require(:tenent).permit(:individual_id, :leased_signed, :lease_expired, :property_id, :room_id)
    end
end
