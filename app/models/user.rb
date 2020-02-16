class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include ActiveModel::Validations

  field :email, type: String
  index({email: 1}, {unique: true, name: 'email_unique_index'})
  field :login, type: String
  index({login: 1}, {unique: true, name: 'login_unique_index'})
  field :password_digest, type: String
  field :name, type: String

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true, length: {minimum: 3}
  validates :password, presence: true, length: {in: 6..20}
  validates :password_confirmation, presence: true
  validates :name, presence: true, length: {minimum: 3}
end
