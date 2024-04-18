class User < ApplicationRecord
  before_validation :capitalize_names
  before_save :encrypt_password
  before_validation :set_default_role, on: :create
  # Other validations, associations, and methods...

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :contact, presence: true, uniqueness: true, length: { is: 10 }, numericality: { only_integer: true }
  validates :password, presence: true, confirmation: true
  validates :role, presence: true, inclusion: { in: %w(user doctor admin) }

  has_one :doctor_detail, dependent: :destroy
  has_many :patients

  accepts_nested_attributes_for :doctor_detail

  scope :get_doctors, -> { where(role: "doctor") }
  scope :get_users, -> { where(role: "user") }

  def as_json(options = {})
    super(options.merge({ except: [:password, :password_digest] }))
  end

  private

  def capitalize_names
    self.first_name = first_name.downcase.strip.capitalize if first_name.present?
    self.last_name = last_name.downcase.strip.capitalize if last_name.present?
  end

  def encrypt_password
    if password.present?
      self.password_digest = BCrypt::Password.create(password)
      self.password = nil
    end
  end

  def set_default_role
    self.role ||= "user"
  end
end