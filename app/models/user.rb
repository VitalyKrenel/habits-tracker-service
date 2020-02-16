class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :email, type: String
  index({email: 1}, {unique: true, name: 'email_unique_index'})
  field :login, type: String
  index({login: 1}, {unique: true, name: 'login_unique_index'})
  field :password, type: String
  field :name, type: String
  has_secure_password
end
