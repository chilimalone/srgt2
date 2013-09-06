class Sale < ActiveRecord::Base
  belongs_to :agent
  belongs_to :buyer, :class_name => "Individual"
  belongs_to :broker, :class_name => "Individual"
  belongs_to :property
  
  attr_accessor :agent_name, :buyer_name, :broker_name, :property_name
  
  def search
    scope = Sale.scoped({})
    scope = scope.scoped :conditions => ["closing_date = ?", closing_date] unless closing_date.blank?
    if (!agent.blank?)
      possible_agents = agent.search
      condition_a = possible_agents.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["agent_id IN ?", "['" + condition_a + "']"]
    end
    if (!property.blank?)
      possible_properties = property.search
      condition_p = possible_properties.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["property_id IN ?", "['" + condition_p + "']"]
    end
    if (!buyer.blank?)
      possible_buyers = buyer.search
      condition_bu = possible_buyers.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["buyer_id IN ?", "['" + condition_bu + "']"]
    end
    if (!broker.blank?)
      possible_brokers = broker.search
      condition_br = possible_brokers.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["broker_id IN ?", "['" + condition_br + "']"]
    end
    scope
  end
end
