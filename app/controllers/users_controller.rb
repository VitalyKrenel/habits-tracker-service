class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :auth_api
  before_action :check_admin

  # GET /users
  def index
    @users = User.all

    render json: @users, except: :password_digest
  end

  # GET /users/1
  def show
    render json: @user, except: :password_digest
  end

  # POST /users
  def create
    begin
      user_params = parse_request(%w(email login password name))
    rescue Exception => e
      render json: e.message and return
    end

    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user, except: :password_digest
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    begin
      user_params = parse_request.select { |key, value| User.attribute_names.include? key }
    rescue Exception => e
      render json: e.message and return
    end

    if @user.update(user_params)
      render json: @user, except: :password_digest
    else
      render json: @user.errors, status: :unprocessable_entity
    end
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
