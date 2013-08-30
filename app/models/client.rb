class Client < ActiveRecord::Base
  belongs_to :individual
  
  def search
    scope = Client.scoped({})
    scope = scope.scoped :conditions => ["username LIKE ?", "%" + username + "%"] unless username.blank?
    scope = scope.scoped :conditions => ["fname LIKE ?", "%" + fname + "%"] unless fname.blank?
    scope = scope.scoped :conditions => ["lname LIKE ?", "%" + lname + "%"] unless lname.blank?
    scope
  end
end
