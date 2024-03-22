# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(name: 'admin', password: '123123', password_confirmation: '123123', username: 'admin', email: 'admin@example.com', phone_number: 1234567898, address: 'street address',
	                                role: 0, state: 'maharastra', city: 'mumbai', pincode: 98887)

Location.create(state: 'maharastra', city: 'mumbai', user_id: user.id)

