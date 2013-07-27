json.array!(@tours) do |tour|
  json.extract! tour, :agent_id, :client_id, :date, :room_id, :comments, :property_id
  json.url tour_url(tour, format: :json)
end
