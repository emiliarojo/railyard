# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# seeds.rb

require 'faker'

Chatroom.delete_all
Message.delete_all
ProjectSkill.delete_all
Request.delete_all
UserSkill.delete_all
Skill.delete_all
Project.delete_all
User.delete_all

# Helper method to create skills
def create_skill(technology, level)
  Skill.find_or_create_by(technology: technology, level: level)
end

# Helper method to create users and associate skills
def create_user(email, password, first_name, last_name, job_description, about_me, provider, uid, skills)
  user = User.find_or_create_by(email: email) do |u|
    u.password = password
    u.first_name = first_name
    u.last_name = last_name
    u.job_description = job_description
    u.about_me = about_me
    u.provider = provider
    u.uid = uid
  end

  # Ensure the user has at most 6 skills
  user_skills = skills.take(6)

  user_skills.each do |skill|
    user.skills << skill unless user.skills.include?(skill)
  end
end

# Create skills
skills_list = [
  { technology: "ActiveRecord", level: "Intermediate" },
  { technology: "Capybara", level: "Advanced" },
  { technology: "Stimulus", level: "Beginner" },
  { technology: "Frontend", level: "Intermediate" },
  { technology: "Backend", level: "Intermediate" },
  { technology: "RSpec", level: "Advanced" },
  { technology: "GraphQL", level: "Beginner" },
  { technology: "Action Cable", level: "Intermediate" },
  { technology: "Heroku", level: "Intermediate" },
  { technology: "PostgreSQL", level: "Advanced" },
  { technology: "Bootstrap", level: "Beginner" },
  { technology: "Devise", level: "Intermediate" },
  { technology: "Webpacker", level: "Beginner" },
  { technology: "HTML", level: "Advanced" },
  { technology: "RSpec", level: "Intermediate" },
  { technology: "jQuery", level: "Beginner" }
]

skills_list.each do |skill_info|
  create_skill(skill_info[:technology], skill_info[:level])
end

# Create users
users_list = []

10.times do
  users_list << {
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    job_description: Faker::Job.title,
    about_me: Faker::Lorem.paragraph,
    provider: "github",
    uid: Faker::Number.unique.number(digits: 6).to_s, # Using unique number to avoid conflicts
    skills: Skill.all.sample(6) # Randomly assign 6 skills to the user
  }
end

# for testing purpose
users_list << {
  email: "test@test.com",
  password: "secret",
  first_name: "Test name",
  last_name: "Test last name",
  job_description: "test",
  about_me: "test",
  provider: "github",
  uid: Faker::Number.unique.number(digits: 6).to_s, # Using unique number to avoid conflicts
  skills: Skill.all.sample(6) # Randomly assign 6 skills to the user
}

users_list.each do |user_info|
  create_user(user_info[:email], user_info[:password], user_info[:first_name], user_info[:last_name],
              user_info[:job_description], user_info[:about_me], user_info[:provider], user_info[:uid], user_info[:skills])
end

# Create projects
def create_project(name, description, amount_of_people, repo_link, user, skills)
  project = Project.find_or_create_by(name: name, description: description, amount_of_people: amount_of_people, repo_link: repo_link, user: user)

  # Ensure the project has at most 6 skills
  project_skills = skills.take(6)

  project_skills.each do |skill|
    project.skills << skill unless project.skills.include?(skill)
  end

  project
end

# ...

projects_list = []

30.times do
  projects_list << {
    name: Faker::App.name,
    description: Faker::Lorem.paragraph,
    amount_of_people: rand(1..10),
    repo_link: Faker::Internet.url,
    user: User.all.sample,
    skills: Skill.all.sample(6) # Randomly assign 6 skills to each project
  }
end

projects_list.each do |project_info|
  create_project(project_info[:name], project_info[:description], project_info[:amount_of_people],
                 project_info[:repo_link], project_info[:user], project_info[:skills])
end

# You can create requests, chatrooms, and messages here as needed.

puts "Seeds data has been created."
