json.array!(@rooms) do |room|
  json.extract! room, :property_id, :comments
  json.url room_url(room, format: :json)
end
