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
    @stat = HabitStat.find({
                               'date': habit_stat_params[:date],
                               'habit_id': habit_stat_params[:id],
                               'user_id': @current_user.id
                           })

    if @stat
      @stat.status = habit_stat_params[:status]
    else
      @stat = HabitStat.new(habit_stat_params)
      @stat.user = @current_user
      @stat.habit = @habit
    end
  end

  # Only allow a trusted parameter "white list" through.
  def habit_stat_params
    params.permit(:status, :date)
  end
end
