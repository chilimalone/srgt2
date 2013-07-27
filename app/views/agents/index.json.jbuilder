json.array!(@agents) do |agent|
  json.extract! agent, :fname, :lname
  json.url agent_url(agent, format: :json)
end
