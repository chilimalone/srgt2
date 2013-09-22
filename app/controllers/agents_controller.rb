class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:index, :show, :edit, :update, :destroy]

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
    else
      flash[:login_errors] = "Authentication failed. Try again."
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
    @agent.req_password = true

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
    @agent.req_password = true
    if current_agent.isAdmin
      temp_agent = Agent.new
      @agent.req_password = false
    else
      temp_agent = Agent.authenticate(@agent.username, params[:agent][:old_password])
      if temp_agent.nil?
        @agent.errors[:old_password] = "Old password is incorrect"
      end
    end
    # Make sure validation passes if password is not updated.
    if params[:agent][:password].blank? && params[:agent][:password_confirmation].blank?
      @agent.req_password = false
    end
    respond_to do |format|
      if ((!temp_agent.nil?) && @agent.update(agent_params))
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
  
  # GETS /agents/search
  def search_form
    render "search"
  end
  
  def auto_agents
    if params[:term] && (params[:term].length > 2)
      users = Agent.search_by_name(params[:term])
    else
      users = Agent.all
    end
    list = users.map {|u| Hash[id: u.id, label: u.name + " (" + u.username + ")", name: u.name]}
    respond_to do |format|
      format.json { render json: list }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(:fname, :lname, :username, :password, :password_confirmation, :old_password, :req_password, :isAdmin)
    end
end
