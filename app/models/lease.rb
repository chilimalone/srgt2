class Lease < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  belongs_to :room
  
  attr_accessor :agent_name, :client_name, :room_name
  
  def search
    scope = Lease.scoped({})
    scope = scope.scoped :conditions => ["rental_amount=?", rental_amount] unless rental_amount.blank?
    scope = scope.scoped :conditions => ["move_out=?", move_out] unless move_out.blank?
    scope = scope.scoped :conditions => ["move_in=?", move_in] unless move_in.blank?
    scope = scope.scoped :conditions => ["referral_amount=?", referral_amount] unless referral_amount.blank?
    if (!client.blank?)
      possible_people = client.search
      if possible_people.size != Client.count
        condition_c = possible_people.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["client_id IN ('" + condition_c + "')"]
      end
    end
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
    scope
  end
end
