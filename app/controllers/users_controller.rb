class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :auth_api
  before_action :check_admin, only: [:destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users, except: :password_digest
  end

  # GET /users/1
  def show
    render json: @user, except: :password_digest
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    @current_user[:login] === 'admin'
  end
end
