class Api::V1::StatsController < ApplicationController
  def game_streak
    user_id = params[:user_id]
    quest = Quest.where('user_id = ? AND status = ?', user_id, 0).first
    render json: UserStatSerializer.new(quest)
  end
end
