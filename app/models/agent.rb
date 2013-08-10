class Agent < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  before_save :encrypt_password, :standardize
  
  validates_confirmation_of :password
  #validates_presence_of :password, :on => create
  #validates_presence_of :username
  validates_uniqueness_of :username
  
  def self.authenticate(username, password)
    user = find_by_username(username.downcase)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def self.search(username)
    
  end
  
  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def standardize
    fname.capitalize! if fname.present?
    lname.capitalize! if lname.present?
    username = username.downcase
  end
  
  has_many :leases
end
