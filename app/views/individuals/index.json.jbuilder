json.array!(@individuals) do |individual|
  json.extract! individual, :fname, :lname, :phone, :street_1, :street_2, :city, :state, :zip, :email
  json.url individual_url(individual, format: :json)
end
