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
      if possible_agents.size != Agent.count
        condition_a = possible_agents.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["agent_id IN ('" + condition_a + "')"]
      end
    end
    if (!room.blank?)
      possible_properties = room.search
      if possible_properties.size != Room.count
        condition_p = possible_properties.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["room_id IN ('" + condition_p + "')"]
      end
    end
    if (!buyer.blank?)
      possible_buyers = buyer.search
      if possible_buyers.size != Individual.count
        condition_bu = possible_buyers.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["buyer_id IN ('" + condition_bu + "')"]
      end
    end
    if (!broker.blank?)
      possible_brokers = broker.search
      if possible_brokers.size != Individual.count
        condition_br = possible_brokers.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["broker_id IN ('" + condition_br + "')"]
      end
    end
    scope
  end
end
