class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_agent
  
  protected
  def current_agent
    @current_agent ||= Agent.find_by_id(session[:currentAgentId]) if session[:currentAgentId]
  end
end
