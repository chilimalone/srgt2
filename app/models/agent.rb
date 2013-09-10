class Agent < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :old_password, :tmp_name
  before_save :encrypt_password, :standardize
  
  validates_confirmation_of :password
  validates :username, uniqueness: true, presence: true
  validates :password, length: { minimum: 6 }
  
  def self.authenticate(username, password)
    user = find_by_username(username.downcase)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def self.search_by_name(name)
    name_condition = name + "%"
    find(:all, :conditions => ['username LIKE ? OR concat(fname, " ", lname)', name_condition, "%" + name_condition])
  end
  
  def name
    "#{fname} #{lname}"
  end
  
  def search
    scope = Agent.scoped({})
    scope = scope.scoped :conditions => ["username LIKE ?", username + "%"] unless username.blank?
    scope = scope.scoped :conditions => ["fname LIKE ?", fname + "%"] unless fname.blank?
    scope = scope.scoped :conditions => ["lname LIKE ?", lname + "%"] unless lname.blank?
    scope
  end
  
  private
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
  
  def standardize
    self.fname = fname.capitalize if fname.present?
    self.lname = lname.capitalize if lname.present?
    self.username = username.downcase
  end
  
  has_many :leases
  has_many :tours
  has_many :sales
end
