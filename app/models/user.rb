class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  has_many :attendances
  has_many :activity_sessions, through: :attendances

  def generate_jwt
    JWT.encode({ id: id,
                  exp: 60.days.from_now.to_i },
                  ENV["SECRET_KEY_BASE"])
  end
end
