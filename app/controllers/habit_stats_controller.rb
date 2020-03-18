class HabitStatsController < ApplicationController
  before_action :auth_api
  before_action :set_habit_stat, only: [:set]

  # POST /habits/1/stats
  def set
    if @stat.save
      render json: @stat, status: :created
    else
      render json: @stat.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_habit_stat
    @habit = @current_user.habits.find(habit_stat_params[:habit_id])

    @stat = @habit.habit_stats.find_by({'date': habit_stat_params[:date]})

    unless @stat
      @stat = @habit.habit_stats.new
      @stat.date = habit_stat_params[:date]
    end

    @stat.status = habit_stat_params[:status]
  end

  # Only allow a trusted parameter "white list" through.
  def habit_stat_params
    params.permit(:status, :date, :habit_id)
  end
end
