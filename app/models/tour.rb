class Tour < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  belongs_to :room
  
  attr_accessor :agent_name, :client_name, :room_name
  
  def search
    scope = Tour.scoped({})
    scope = scope.scoped :conditions => ["date = ?", date] unless date.blank?
    scope = scope.scoped :conditions => ["dropped_date = ?", dropped_date] unless dropped_date.blank?
    if (!agent.blank?)
      possible_agents = agent.search
      condition_a = possible_agents.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["agent_id IN ?", "['" + condition_a + "']"]
    end
    if (!client.blank?)
      possible_clients = client.search
      condition_c = possible_clients.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["client_id IN ?", "['" + condition_c + "']"]
    end
    if (!room.blank?)
      possible_rooms = room.search
      condition_pr = possible_rooms.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["room_id IN ?", "['" + condition_pr + "']"]
    end
    scope = scope.scoped :conditions => ["comments LIKE ?", comments] unless comments.blank?
    scope
  end
end
