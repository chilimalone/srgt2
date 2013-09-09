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
end
