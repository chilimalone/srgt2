json.array!(@leases) do |lease|
  json.extract! lease, :client_id, :rental_amount, :move_out, :date, :move_in, :thank_you_sent, :comments, :agent_id, :referral_amount, :room_id
  json.url lease_url(lease, format: :json)
end
