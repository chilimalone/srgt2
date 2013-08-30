class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  # GET /agents.json
  def index
    @agents = Agent.all
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
  end

  # GET /agents/new
  def new
    @agent = Agent.new
  end

  # GET /agents/1/edit
  def edit
  end
  
  # Log in
  def login
    username = params[:agent][:username]
    password = params[:agent][:password]
    user = Agent.authenticate(username, password)
    
    if user
      session[:currentAgentId] = user.id
    end
    redirect_to root_path
  end
  
  # Log out
  def logout
    reset_session
    redirect_to root_path
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new(agent_params)

    respond_to do |format|
      if @agent.save
        format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
        format.json { render action: 'show', status: :created, location: @agent }
      else
        format.html { render action: 'new' }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url }
      format.json { head :no_content }
    end
  end
  
  # PUTS /agents/search
  def search
    @agent = Agent.new(agent_params)
    @agents = @agent.search
    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(:fname, :lname, :username, :password, :password_confirmation)
    end
end
