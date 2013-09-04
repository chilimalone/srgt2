class Property < ActiveRecord::Base
  belongs_to :individual
  has_many :rooms
  has_many :leases
  has_many :tenants
  has_many :tours
  has_many :sales
  
  def address
    "#{street_1} #{city} #{state}"
  end
  
  def search
    scope = Property.scoped({})
    scope = scope.scoped :conditions => ["street_1 LIKE ?", "%" + street_1 + "%"] unless street_1.blank?
    scope = scope.scoped :conditions => ["street_2 LIKE ?", "%" + street_2 + "%"] unless street_2.blank?
    scope = scope.scoped :conditions => ["city LIKE ?", "%" + city + "%"] unless city.blank?
    scope = scope.scoped :conditions => ["state LIKE ?", "%" + state + "%"] unless state.blank?
    scope = scope.scoped :conditions => ["zip LIKE ?", "%" + zip + "%"] unless zip.blank?
    if (!individual.blank?)
      possible_people = individual.search
      condition = possible_people.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["individual_id IN ?", "['" + condition + "']"]
    end
    scope
  end
end
