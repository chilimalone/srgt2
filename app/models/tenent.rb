class Tenent < ActiveRecord::Base
  belongs_to :individual
  belongs_to :property
  belongs_to :room
end
