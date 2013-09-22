class Room < ActiveRecord::Base
  belongs_to :property
  belongs_to :individual
  has_many :tours
  has_many :tenants
  has_many :sales
  has_many :leases
  attr_accessor :property_name, :individual_name
  
  def self.search_by_number(num)
    possible_properties = Property.search_by_address(num)
    posquery = possible_properties.map { |p| p.id.to_s }.join("', '")
    find(:all, :conditions => ["room_number LIKE ? OR property_id IN ('#{posquery}')", "%#{num}%"])
  end
  
  def search
    scope = Room.scoped({})
    scope = scope.scoped :conditions => ["room_number LIKE ?", room_number] unless room_number.blank?
    if (!property.blank?)
      possible_properties = property.search
      if possible_properties.size != Property.count
        condition_p = possible_properties.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["property_id IN ('" + condition_p + "')"]
      end
    end
    if (!individual.blank?)
      possible_people = individual.search
      if possible_people.size != Individual.count
        condition = possible_people.map { |p| p.id.to_s }.join("', '")
        scope = scope.scoped :conditions => ["individual_id IN ('" + condition + "')"]
      end
    end
    scope
  end
end
