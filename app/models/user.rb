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
  # has_many :coach_groups, :foreign_key => "user_id", :class_name => "Group"
  has_many :coach_activities, :foreign_key => "user_id", :class_name => "Activity"
  # has_one_attached :photo
  has_one_base64_attached :photo

  def generate_jwt
    JWT.encode({ id: id,
                  exp: 365.days.from_now.to_i },
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
    if photo_attached
      "https://baton-app-images.s3.amazonaws.com/users/#{id}"
    else
      placeholder
    end
  end

  def is_coach?
    memberships.any? do |membership|
      membership.role == 2 || membership.role == 1
    end
  end

  def coach_groups
    memberships.filter_map do |membership|
      membership.group if membership.role == 2 || membership.role == 1
    end
  end

  def user_groups
    memberships.filter_map do |membership|
      membership.group if membership.role == 0
    end
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    self.passwoord_confirmation = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end