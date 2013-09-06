class Tenant < ActiveRecord::Base
  belongs_to :individual
  belongs_to :property
  belongs_to :room
  
  attr_accessor :individual_name, :property_name, :room_name
  
  def search
    scope = Tenant.scoped({})
    scope = scope.scoped :conditions => ["leased_signed = ?", leased_signed] unless leased_signed.blank?
    scope = scope.scoped :conditions => ["lease_expired = ?", lease_expired] unless lease_expired.blank?
    if (!room.blank?)
      possible_properties = room.search
      condition_p = possible_properties.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["property_id IN ?", "['" + condition_p + "']"]
    end
    if (!individual.blank?)
      possible_buyers = individual.search
      condition_bu = possible_buyers.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["buyer_id IN ?", "['" + condition_bu + "']"]
    end
    scope
  end
end
