json.array!(@properties) do |property|
  json.extract! property, :street_1, :street_2, :city, :state, :zip, :notes, :individual_id
  json.url property_url(property, format: :json)
end
