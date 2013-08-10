json.array!(@leases) do |lease|
  json.extract! lease, :client_id, :rental_amount, :move_out, :date, :move_in, :welcome_home, :thank_you_sent, :dropped_date, :comments, :agent_id, :referral_amount, :property_id
  json.url lease_url(lease, format: :json)
end
