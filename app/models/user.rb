class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills
  has_many :projects, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :messages, dependent: :destroy
end
