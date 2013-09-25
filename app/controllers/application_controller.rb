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
    params[:client] = check_params(params[:client])
    return nil if params[:client].blank?
    ci = Client.new(clients_params(params[:client]))
    ci.individual = nil
    ci.individual = Individual.new(individuals_params(params[:client][:individual])) unless params[:client][:individual].blank?
    return ci
  end
  
  def createRoom(params)
    params[:room] = check_params(params[:room])
    return nil if params[:room].blank?
    rm = Room.new(rooms_params(params[:room]))
    rm.property = nil
    rm.individual = nil
    rm.property = Property.new(propertys_params(params[:room][:property])) unless params[:room][:property].blank?
    rm.individual = Individual.new(individuals_params(params[:room][:individual])) unless params[:room][:individual].blank?
    return rm
  end
  
  def createAgent(params)
    params[:agent] = check_params(params[:agent])
    return nil if params[:agent].blank?
    return Agent.new(agents_params(params[:agent]))
  end
  
  def createIndividual(params)
    params[:individual] = check_params(params[:individual])
    return nil if params[:individual].blank?
    return Individual.new(individuals_params(params[:individual]))
  end
  
  def check_params(param_array)
    param_array.each do |k, v|
      if v.is_a?(Hash)
        v = check_params(v)
      end
      param_array[k] = {} if v.blank?
    end
    return param_array
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
    param_array.permit(:property_id, :property_name, :comments, :individual_id, :individual_name, :room_number)
  end
end
