class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills
  has_many :projects, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :photo

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split.first
      user.last_name = auth.info.name.split[1..-1].join(" ")
      user.github_link = auth.info.urls.GitHub
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["name"].split.first if user.first_name.blank?
        user.last_name = data["name"].split[1..-1].join(" ") if user.last_name.blank?
        user.github_link = data["urls"]["GitHub"] if user.github_link.blank?
      end
    end
  end
end
