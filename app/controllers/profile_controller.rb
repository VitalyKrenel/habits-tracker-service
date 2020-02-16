class ProfileController < ApplicationController
  before_action :auth_api, only: [:me, :edit]

  def auth
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: {auth_token: command.result}
    else
      render json: {error: command.errors}, status: :unauthorized
    end
  end

  def register
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user, except: :password_digest
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit
    unless @current_user.authenticate(params[:current_password])
      render json: {error: 'Invalid password'}, status: 403 and return
    end

    if @current_user.login === 'admin'
      render json: {message: 'stop this shit'}, status: 418 and return
    end

    if @current_user.update(user_params)
      render json: @current_user, except: :password_digest
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :login, :password, :password_confirmation)
  end
end
