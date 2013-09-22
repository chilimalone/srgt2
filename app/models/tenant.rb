class Tenant < ActiveRecord::Base
  belongs_to :individual
  belongs_to :room
  
  attr_accessor :individual_name, :room_name
  
  def search
    scope = Tenant.scoped({})
    scope = scope.scoped :conditions => ["leased_signed = ?", leased_signed] unless leased_signed.blank?
    scope = scope.scoped :conditions => ["lease_expired = ?", lease_expired] unless lease_expired.blank?
    scope = scope.scoped :conditions => ["welcome_home = ?", welcome_home] unless welcome_home.blank?
    if (!room.blank?)
      possible_properties = room.search
      if possible_properties.size != Room.count
        condition_p = possible_properties.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["room_id IN ('" + condition_p + "')"]
      end
    end
    if (!individual.blank?)
      possible_buyers = individual.search
      if possible_buyers.size != Individual.count
        condition_bu = possible_buyers.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["individual_id IN ('" + condition_bu + "')"]
      end
    end
    scope
  end
end
