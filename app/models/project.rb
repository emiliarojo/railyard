class Project < ApplicationRecord
  # include PgSearch::Model
  # pg_search_scope :search_by_name_and_description,
  # against: [ :name, :description ],
  # using: {
  #   tsearch: { prefix: true } # <-- now `superman batm` will return something!
  # }

  belongs_to :user
  has_many :requests, dependent: :destroy
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills
  has_one :chatroom, dependent: :destroy
end
