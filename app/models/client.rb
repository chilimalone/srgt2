class Client < ActiveRecord::Base
  belongs_to :individual
  has_many :tours
  has_many :leases
  attr_accessor :individual_name
  
  def name
    "#{individual.fname} #{individual.lname}"
  end
  
  def self.search_by_name(name)
    name_condition = name + "%"
    possible_people = Individual.search_by_name(name)
    condition = possible_people.map { |p| p.to_s }.join("', '")
    find(:all, :conditions => ["individual_id IN ? OR company LIKE ?", "['" + condition + "']", name_condition])
  end
  
  def search
    scope = Client.scoped({})
    scope = scope.scoped :conditions => ["file_number = ?", file_number] unless file_number.blank?
    scope = scope.scoped :conditions => ["source LIKE ?", "%" + source + "%"] unless source.blank?
    scope = scope.scoped :conditions => ["company LIKE ?", "%" + company + "%"] unless company.blank?
    scope = scope.scoped :conditions => ["price = ", price] unless price.blank?
    scope = scope.scoped :conditions => ["date_received = ?", "'" + date_received.to_s + "'"] unless date_received.blank?
    if (!individual.blank?)
      possible_people = individual.search
      condition = possible_people.map { |p| p.to_s }.join("', '")
      scope = scope.scoped :conditions => ["individual_id IN ?", "['" + condition + "']"]
    end
    scope
  end
end
