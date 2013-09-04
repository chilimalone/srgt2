class Room < ActiveRecord::Base
  belongs_to :property
  has_many :tours
  has_many :tenants
  
  def search
    scope = Room.scoped({})
    scope = scope.scoped :conditions => ["room_number = ?", room_number] unless room_number.blank?
    if (!property.blank?)
      possible_properties = property.search
      condition_p = possible_properties.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["property_id IN ?", "['" + condition_p + "']"]
    end
    scope
  end
end
