# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Deal.skip_callback(:address, :geocode)
connection = ActiveRecord::Base.connection();

FOOD_TYPES = [ 'American','Mexican','Italian','Asian','French' ]
DEAL_TYPES = [ 'Free','Buy One Get One Free','Buy One Get One Half Off','Flash Deal' ]
FOOD_NAMES = [ 'Cheese Pizza', 'Hamburger', 'Cheese Burger', 'Hotdog', 'Icee', 'Pasta', 'Sausage', 'Chicken Bowl']
#create 10,000 users
num_users = 1000
deal_id_count = 1

(1..num_users).each do |user_number|
	a = User.create!(name: "user#{user_number}", 
		email: "user#{user_number}@foodfinder.com", 
		password: "password#{user_number}", 
		password_confirmation: "password#{user_number}", 
		phone_number: "18058938000", 
		food_type: FOOD_TYPES.sample, 
		address: "Harold Frank Hall, 1138 Lagoon Rd, Isla Vista, CA 93117")
	10.times do |i|
  	Deal.connection.execute "insert into deals 
  	(id, food_name, latitude, longitude, address, food_type, start_time, end_time, user_id, deal_type, created_at, updated_at) 
  	values (#{deal_id_count}, '#{FOOD_NAMES.sample}', #{rand * 0.037484 + 34.409627}, #{rand * 0.193776 - 119.878732}, 'Harold Frank Hall, 1138 Lagoon Rd, Isla Vista, CA 93117', '#{FOOD_TYPES.sample}', NOW(), NOW(), #{a.id}, '#{DEAL_TYPES.sample}', NOW(), NOW());"
  	deal_id_count += 1
	end
end

