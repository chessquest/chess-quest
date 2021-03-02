class Api::V1::StatsController < ApplicationController
  NUM_TOP_QUESTS = 3

  def game_streak
    user_id = params[:user_id]
    quest = Quest.where('user_id = ? AND status = ?', user_id, 0).first
    render json: UserStatSerializer.new(quest)
  end

  def top_quests
    quests = Quest.joins(:games)
      .select("quests.*, count(games.status) as num_wins")
      .where("games.status = '1'")
      .group('quests.id')
      .order("num_wins DESC")
      .limit(NUM_TOP_QUESTS)

    render json: QuestStatSerializer.new(quests)
  end
end
