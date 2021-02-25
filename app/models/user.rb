class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include ActiveStorageSupport::SupportForBase64
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation

  # TODO Remove
  # validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  has_many :attendances
  has_many :activities, -> { distinct }, through: :attendances
  has_many :memberships
  has_many :groups, -> { distinct }, through: :memberships
  has_many :coach_groups, :foreign_key => "user_id", :class_name => "Group"
  # has_one_attached :photo
  has_one_base64_attached :photo


  def generate_jwt
    JWT.encode({ id: id,
                  exp: 60.days.from_now.to_i },
                  ENV["SECRET_KEY_BASE"])
  end

  def placeholder
    "https://batonapprunner.s3.amazonaws.com/profile-image-placeholder.png"
  end

  def password_required?
    return false if skip_password_validation
    super
  end

  def photo_url
    c = GetPhoto.call(activity: "users/#{id}")
    c.url
  end

end