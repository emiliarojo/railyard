class Project < ApplicationRecord
  belongs_to :user
  has_many :requests, dependent: :destroy
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills
  has_one :chatroom, dependent: :destroy
end
