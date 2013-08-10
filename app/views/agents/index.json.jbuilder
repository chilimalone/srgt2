json.array!(@agents) do |agent|
  json.extract! agent, :fname, :lname, :username
  json.url agent_url(agent, format: :json)
end
