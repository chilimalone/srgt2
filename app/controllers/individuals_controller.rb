class IndividualsController < ApplicationController
  before_action :set_individual, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  # GET /individuals
  # GET /individuals.json
  def index
    @individuals = Individual.all
  end

  # GET /individuals/1
  # GET /individuals/1.json
  def show
  end

  # GET /individuals/new
  def new
    @individual = Individual.new
  end

  # GET /individuals/1/edit
  def edit
  end

  # POST /individuals
  # POST /individuals.json
  def create
    @individual = Individual.new(individual_params)

    respond_to do |format|
      if @individual.save
        format.html { redirect_to @individual, notice: 'Individual was successfully created.' }
        format.json { render action: 'show', status: :created, location: @individual }
      else
        format.html { render action: 'new' }
        format.json { render json: @individual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /individuals/1
  # PATCH/PUT /individuals/1.json
  def update
    respond_to do |format|
      if @individual.update(individual_params)
        format.html { redirect_to @individual, notice: 'Individual was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @individual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /individuals/1
  # DELETE /individuals/1.json
  def destroy
    @individual.destroy
    respond_to do |format|
      format.html { redirect_to individuals_url }
      format.json { head :no_content }
    end
  end
  
  # GET /individuals/search
  def search_form
    render 'search'
  end
  
  #POST /individuals/search
  def search
    @individual = Individual.new(individual_params)
    @individuals = @individual.search
    render "index"
  end
  
  def auto_contacts
    if params[:term] && (params[:term].length > 2)
      users = Individual.search_by_name(params[:term])
    else
      users = Individual.all
    end
    list = users.map {|u| Hash[id: u.id, label: u.name + " (" + u.email + ")", name: u.name]}
    respond_to do |format|
      format.json { render json: list }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual
      @individual = Individual.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_params
      params.require(:individual).permit(:fname, :lname, :phone, :street_1, :street_2, :city, :state, :zip, :email)
    end
end
