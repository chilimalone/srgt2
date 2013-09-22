json.array!(@tenants) do |tenant|
  json.extract! tenant, :individual_id, :leased_signed, :lease_expired, :property_id, :room_id, :welcome_home
  json.url tenant_url(tenant, format: :json)
end
