class Individual < ActiveRecord::Base
  has_many :clients
  has_many :properties
end
