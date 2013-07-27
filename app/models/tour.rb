class Tour < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  belongs_to :room
  belongs_to :property
end
