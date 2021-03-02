class Api::V1::StatsController < ApplicationController
  def game_streak
    user_id = params[:user_id]
    quest = Quest.where('user_id = ? AND status = ?', user_id, 0).first

    temp = {
      data: {
        type: "user_stats",
        attributes: {
          quest_id: quest.id,
          streak: quest.games.where(status: :won).count
        }
      }
    }

    render json: temp
  end
end
