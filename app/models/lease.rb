class Lease < ActiveRecord::Base
  belongs_to :agent
  belongs_to :client
  belongs_to :property
  
  def search
    scope = Lease.scoped({})
    scope = scope.scoped :conditions => ["rental_amount = ", rental_amount] unless rental_amount.blank?
    scope = scope.scoped :conditions => ["move_out = ", move_out] unless move_out.blank?
    scope = scope.scoped :conditions => ["move_in =", move_in] unless move_in.blank?
    scope = scope.scoped :conditions => ["dropped_date =", dropped_date] unless dropped_date.blank?
    scope = scope.scoped :conditions => ["referral amount =", referral_amount] unless referral_amount.blank?
    scope
  end
end
