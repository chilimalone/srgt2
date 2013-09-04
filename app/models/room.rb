class Room < ActiveRecord::Base
  belongs_to :property
  has_many :tours
  has_many :tenants
  
  def search
    scope = Room.scoped({})
    scope = scope.scoped :conditions => ["room_number = ?", room_number] unless room_number.blank?
    scope
  end
end
