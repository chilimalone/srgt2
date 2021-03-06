class Individual < ActiveRecord::Base
  has_one :client
  has_one :tenant
  has_many :rooms
  has_many :sales
  
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  def name
    "#{fname} #{lname}"
  end
  
  def self.search_by_name(name)
    name_condition = "%" + name + "%"
    find(:all, :conditions => ['email LIKE ? OR fname || \' \' || lname LIKE ?', name_condition, name_condition])
  end
  
  def search
    scope = Individual.scoped({})
    scope = scope.scoped :conditions => ["fname LIKE ?", fname + "%"] unless fname.blank?
    scope = scope.scoped :conditions => ["lname LIKE ?", lname + "%"] unless lname.blank?
    scope = scope.scoped :conditions => ["phone LIKE ?", "%" + phone + "%"] unless phone.blank?
    scope = scope.scoped :conditions => ["street_1 LIKE ?", street_1 + "%"] unless street_1.blank?
    scope = scope.scoped :conditions => ["street_2 LIKE ?", street_2 + "%"] unless street_2.blank?
    scope = scope.scoped :conditions => ["city LIKE ?", "%" + city + "%"] unless city.blank?
    scope = scope.scoped :conditions => ["state LIKE ?", state + "%"] unless state.blank?
    scope = scope.scoped :conditions => ["zip LIKE ?", zip + "%"] unless zip.blank?
    scope = scope.scoped :conditions => ["email LIKE ?", "%" + email + "%"] unless email.blank?
    scope
  end
end
