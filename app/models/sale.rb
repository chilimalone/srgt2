class Sale < ActiveRecord::Base
  belongs_to :agent
  belongs_to :buyer, :class_name => "Individual"
  belongs_to :broker, :class_name => "Individual"
  belongs_to :room
  
  attr_accessor :agent_name, :buyer_name, :broker_name, :room_name
  
  def search
    scope = Sale.scoped({})
    scope = scope.scoped :conditions => ["closing_date = ?", closing_date] unless closing_date.blank?
    scope = scope.scoped :conditions => ["hear LIKE ?", hear] unless hear.blank?
    if (!agent.blank?)
      possible_agents = agent.search
      condition_a = possible_agents.map { |p| p.id.to_s }.join("', '")
      scope = scope.scoped :conditions => ["agent_id IN ('" + condition_a + "')"]
    end
    if (!room.blank?)
      possible_properties = room.search
      condition_p = possible_properties.map { |p| p.id.to_s }.join("', '")
      scope = scope.scoped :conditions => ["room_id IN ('" + condition_p + "')"]
    end
    if (!buyer.blank?)
      possible_buyers = buyer.search
      condition_bu = possible_buyers.map { |p| p.id.to_s }.join("', '")
      scope = scope.scoped :conditions => ["buyer_id IN ('" + condition_bu + "')"]
    end
    if (!broker.blank?)
      possible_brokers = broker.search
      condition_br = possible_brokers.map { |p| p.id.to_s }.join("', '")
      scope = scope.scoped :conditions => ["broker_id IN ('" + condition_br + "')"]
    end
    scope
  end
end
