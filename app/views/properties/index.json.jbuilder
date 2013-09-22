json.array!(@properties) do |property|
  json.extract! property, :street_1, :street_2, :city, :state, :zip, :notes, :rooms
  json.url property_url(property, format: :json)
end
