class Skill < ApplicationRecord
  has_many :user_skills, dependent: :destroy
  has_many :project_skills, dependent: :destroy
end
