json.array!(@tenents) do |tenent|
  json.extract! tenent, :individual_id, :leased_signed, :lease_expired, :property_id, :room_id
  json.url tenent_url(tenent, format: :json)
end
