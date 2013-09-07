# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
when "development"
  Agent.create(:fname => "Admin", :lname => "Admin", :username => "Administrator", :password => "password", :password_confirmation => "password", :isAdmin => true)
when "production"
  Agent.create(:fname => "Admin", :lname => "Admin", :username => "Administrator", :password => "Pa5sW0rD", :password_confirmation => "Pa5sW0rD", :isAdmin => true)
end