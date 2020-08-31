class HabitStatsController < ApplicationController
  before_action :auth_api
  before_action :set_habit_stat, only: [:set]

  # POST /habits/1/stats
  def set
    @stat.status = params[:status]

    if @stat.save
      render json: @stat, status: :created
    else
      render json: @stat.errors, status: :unprocessable_entity
    end
  end

  # GET /habits/1/stats
  def get
    @stat = @current_user.habits.find(params[:habit_id]).habit_stats.order_by({date: 1})

    if @stat
      render json: paginate(@stat), except: :_id
    else
      render json: {:error => 'Not found'}, status: :not_found
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_habit_stat
    @stat = @current_user
                .habits.find(params[:habit_id])
                .habit_stats.find_or_create_by({
                                                   'date': params[:date]
                                               })
  end
end
