json.array!(@clients) do |client|
  json.extract! client, :comments, :file_number, :source, :company, :date_received, :confirmed, :comments, :individual_id
  json.url client_url(client, format: :json)
end
