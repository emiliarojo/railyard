# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# Clear existing data from the "users" table to avoid duplication
User.delete_all

# Create ten sample users
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: "#{first_name} #{last_name}", domain: 'example.com')
  password = Faker::Internet.password(min_length: 8)
  job_description = 'Rails Developer'
  about_me = Faker::Lorem.paragraph

  User.create!(
    email: email,
    password: password,
    first_name: first_name,
    last_name: last_name,
    job_description: job_description,
    about_me: about_me
  )
end

puts "Seed data created successfully!"
