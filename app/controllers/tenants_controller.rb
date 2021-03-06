class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /tenants
  # GET /tenants.json
  def index
    @tenants = Tenant.all
  end

  # GET /tenants/1
  # GET /tenants/1.json
  def show
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
  end

  # GET /tenants/1/edit
  def edit
    if @tenant.individual
      @tenant.individual_name = @tenant.individual.name
    end
    if @tenant.room
      @tenant.room_name = @tenant.room.room_number + " (#{@tenant.room.property.address})"
    end
  end

  # POST /tenants
  # POST /tenants.json
  def create
    @tenant = Tenant.new(tenant_params)

    respond_to do |format|
      if @tenant.save
        format.html { redirect_to @tenant, notice: 'Tenant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tenant }
      else
        format.html { render action: 'new' }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tenants/1
  # PATCH/PUT /tenants/1.json
  def update
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: 'Tenant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tenants/1
  # DELETE /tenants/1.json
  def destroy
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to tenants_url }
      format.json { head :no_content }
    end
  end
  
  # PUTS /tenants/search
  def search
    @tenant = Tenant.new(tenant_params)
    @tenant.individual = createIndividual(params[:tenant])
    @tenants = @tenant.search
    render "index"
  end
  
  # GETS /tenants/search
  def search_form
    render "search"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tenant_params
      params.require(:tenant).permit(:individual_id, :individual_name, :welcome_home, :leased_signed, :lease_expired, :room_id, :room_name)
    end
end
