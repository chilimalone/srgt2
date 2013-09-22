class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_agent
  
  protected
  def current_agent
    @current_agent ||= Agent.find_by_id(session[:currentAgentId]) if session[:currentAgentId]
  end
  
  def authenticate_user
    if current_agent.nil?
      flash[:big_errors] = 'You must be signed in to view that page.'
      redirect_to root_path
    end
  end
  
  def createClient(params)
    idv = Individual.new(individuals_params(params[:client][:individual]))
    cl = Client.new(clients_params(params[:client]))
    cl.individual = idv
    return cl
  end
  
  def createRoom(params)
    prp = Property.new(propertys_params(params[:room][:property]))
    idv = Individual.new(individuals_params(params[:room][:individual]))
    rm = Room.new(rooms_params(params[:room]))
    rm.individual = idv
    rm.property = prp
    return rm
  end
  
  def createAgent(params)
    return Agent.new(agents_params(params[:agent]))
  end
  
  def createIndividual(params)
    return Individual.new(individuals_params(params[:individual]))
  end
  
  def clients_params(param_array)
    param_array.permit(:comments, :file_number, :source, :company, :date_received, :confirmed, :comments, :individual_id, :individual_name)
  end
  
  def individuals_params(param_array)
    param_array.permit(:fname, :lname, :phone, :street_1, :street_2, :city, :state, :zip, :email)
  end
  
  def agents_params(param_array)
    param_array.permit(:fname, :lname, :username)
  end
  
  def propertys_params(param_array)
    param_array.permit(:name, :street_1, :street_2, :city, :state, :zip, :notes)
  end
  
  def rooms_params(param_array)
    param_array.permit(:property_id, :property_name, :comments, :individual_id, :individual_name)
  end
end
