class Sale < ActiveRecord::Base
  belongs_to :agent
  belongs_to :buyer, :class_name => "Individual", :foreign_key => 'buyer_id'
  belongs_to :property
end
