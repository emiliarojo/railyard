class Skill < ApplicationRecord
  has_many :user_skills, dependent: :destroy
  has_and_belongs_to_many :users, through: :user_skills
  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills
end
