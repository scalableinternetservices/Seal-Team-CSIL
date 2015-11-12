# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FOOD_TYPES = [ 'American','Mexican','Italian','Asian','French' ]
num_users = 10
1.upto(num_users) do |user_number|
	User.create!(name: "user#{user_number}", email: "user#{user_number}@foodfinder.com", password: "password#{user_number}", password_confirmation: "password#{user_number}", phone_number: "18058938000", food_type: FOOD_TYPES.sample, address: "Harold Frank Hall, 1138 Lagoon Rd, Isla Vista, CA 93117")
end