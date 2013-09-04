class Sale < ActiveRecord::Base
  belongs_to :agent
  belongs_to :buyer, :class_name => "Individual"
  belongs_to :broker, :class_name => "Individual"
  belongs_to :property
  
  def search
    scope = Sale.scoped({})
    scope = scope.scoped :conditions => ["closing_date = ?", closing_date] unless closing_date.blank?
    scope
  end
end
