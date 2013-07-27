class Lease < ActiveRecord::Base
  belongs_to :client
  belongs_to :property
end
