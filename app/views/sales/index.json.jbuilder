json.array!(@sales) do |sale|
  json.extract! sale, :agent_id, :hear, :buyer_id, broker_id, :property_id, :closing_date, :company, :office_number
  json.url sale_url(sale, format: :json)
end
