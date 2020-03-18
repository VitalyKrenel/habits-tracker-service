class HabitsController < ApplicationController
  before_action :auth_api
  before_action :set_habit, only: [:update, :destroy, :show]
  before_action :validate_habit_name, only: [:create, :update]

  # GET /habits
  def index
    # get habits for current user only
    render json: @current_user.habits.only(
        :name,
        :description,
    )
  end

  # POST /habits
  def create
    # create habit for current user
    @habit = Habit.new(habit_params)
    @habit.user = @current_user

    if @habit.save
      render json: @habit, status: :created, location: @habit
    else
      render json: @habit.errors, status: :unprocessable_entity
    end
  end

  # GET /habits/1
  def show
    if @habit
      render json: @habit
    else
      render json: {:error => 'Not found'}, status: :not_found
    end
  end

  # PATCH/PUT /habits/1
  def update
    if @habit.update(habit_params)
      render json: @habit
    else
      render json: @habit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /habits/1
  def destroy
    @habit.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_habit
    @habit = @current_user.habits.find(params[:id]).attributes.except(:user_id)
  end

  # Only allow a trusted parameter "white list" through.
  def habit_params
    params.permit(:name, :description, :date, :status)
  end

  def validate_habit_name
    if @current_user.habits.where({'name': habit_params[:name]}).exists?
      render json: {:name => ['is already exists']}, status: :unprocessable_entity
    end
  end
end
