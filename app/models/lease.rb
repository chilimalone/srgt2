class Lease < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  belongs_to :property
  
  def search
    scope = Lease.scoped({})
    scope = scope.scoped :conditions => ["rental_amount = ", rental_amount] unless rental_amount.blank?
    scope = scope.scoped :conditions => ["move_out = ", move_out] unless move_out.blank?
    scope = scope.scoped :conditions => ["move_in =", move_in] unless move_in.blank?
    scope = scope.scoped :conditions => ["dropped_date =", dropped_date] unless dropped_date.blank?
    scope = scope.scoped :conditions => ["referral amount =", referral_amount] unless referral_amount.blank?
    if (!client.blank?)
      possible_people = client.search
      condition_c = possible_people.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["client_id IN ?", "['" + condition_c + "']"]
    end
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
    scope
  end
end
