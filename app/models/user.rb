class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include ActiveModel::Validations

  EMAIL_REGEXP = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

  field :email, type: String
  index({email: 1}, {unique: true, name: 'email_unique_index'})
  field :login, type: String
  index({login: 1}, {unique: true, name: 'login_unique_index'})
  field :password_digest, type: String
  field :name, type: String

  has_secure_password

  validates :password, length: {in: 6..20}, presence: true
  validates :email, uniqueness: true, format: {
      with: EMAIL_REGEXP,
      message: 'invalid email format'
  }, allow_blank: true
  validates :login, uniqueness: true, length: {minimum: 3}, allow_blank: true

  validates :email, on: :create, presence: true
  validates :login, on: :create, presence: true
  validates :password, on: :create, confirmation: true
  validates :password_confirmation, on: :create, presence: true
  validates :name, on: :create, presence: true
end
