# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed file (db/seeds.rb)
require 'faker'

# Clear existing data from the "users" table to avoid duplication
User.delete_all

# Add the 15 most important skills for Rails developers
skills_list = [
  { technology: 'Ruby', level: 'Advanced' },
  { technology: 'Ruby on Rails', level: 'Advanced' },
  { technology: 'ActiveRecord', level: 'Intermediate' },
  { technology: 'HTML/CSS', level: 'Intermediate' },
  { technology: 'JavaScript', level: 'Intermediate' },
  { technology: 'RSpec', level: 'Intermediate' },
  { technology: 'Capybara', level: 'Intermediate' },
  { technology: 'Git', level: 'Intermediate' },
  { technology: 'Deployment', level: 'Intermediate' },
  { technology: 'Authentication', level: 'Intermediate' },
  { technology: 'Authorization', level: 'Intermediate' },
  { technology: 'Security', level: 'Intermediate' },
  { technology: 'REST API Design', level: 'Intermediate' },
  { technology: 'Database Management', level: 'Intermediate' },
  { technology: 'Background Processing', level: 'Intermediate' },
  { technology: 'Performance Optimization', level: 'Intermediate' },
  { technology: 'Error Handling', level: 'Intermediate' }
]

skills_list.each do |skill_attrs|
  Skill.find_or_create_by(skill_attrs)
end

# Create ten sample users
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: "#{first_name} #{last_name}", domain: 'example.com')
  password = Faker::Internet.password(min_length: 8)
  job_description = 'Rails Developer'
  about_me = Faker::Lorem.paragraph

  user = User.create!(
    email: email,
    password: password,
    first_name: first_name,
    last_name: last_name,
    job_description: job_description,
    about_me: about_me
  )

  # Add skills to the user using sample skills from the skills_list
  user_skills = Skill.all.sample(rand(1..6)) # Assuming each user will have 1 to 6 skills
  user.skills << user_skills
end


puts "Seed data created successfully!"
