class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    if user
      # move to config or env
      data = {user_id: user.id, exp: Time.now.to_i + 24 * 3600}
      secret = ENV['JWT_SECRET']
      algo = ENV['JWT_ALGO']

      JWT.encode(data, secret, algo)
    end
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
