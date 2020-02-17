class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :update, :destroy]

  # GET /habits
  def index
    # get habits for current user only
    @habits = Habit.all

    render json: @habits
  end

  # GET /habits/1
  def show
    # get habits for current user only
    render json: @habit
  end

  # POST /habits
  def create
    # create current for current user
    @habit = Habit.new(habit_params)
    @habit.user = User.find(habit_params[:user_id])

    if @habit.save
      render json: @habit, status: :created, location: @habit
    else
      render json: @habit.errors, status: :unprocessable_entity
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
      @habit = Habit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def habit_params
      params.permit(:name, :description, :user_id)
    end
end
