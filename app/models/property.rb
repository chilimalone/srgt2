class Property < ActiveRecord::Base
  has_many :rooms
  
  accepts_nested_attributes_for :rooms, :reject_if => lambda { |a| a[:room_number].empty? }, :allow_destroy => true
  
  def address
    "#{street_1} #{city} #{state}"
  end
  
  def self.search_by_address(addr)
    name_condition = "%" + addr + "%"
    find(:all, :conditions => ['(street_1 || \' \' || city || \' \' || state) LIKE ?', name_condition])
  end
  
  def search
    scope = Property.scoped({})
    scope = scope.scoped :conditions => ["name LIKE ?", "%" + name + "%"] unless name.blank?
    scope = scope.scoped :conditions => ["street_1 LIKE ?", "%" + street_1 + "%"] unless street_1.blank?
    scope = scope.scoped :conditions => ["city LIKE ?", "%" + city + "%"] unless city.blank?
    scope = scope.scoped :conditions => ["state LIKE ?", "%" + state + "%"] unless state.blank?
    scope = scope.scoped :conditions => ["zip LIKE ?", "%" + zip + "%"] unless zip.blank?
    scope
  end
end
