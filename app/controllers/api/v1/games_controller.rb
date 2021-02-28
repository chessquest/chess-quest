class Api::V1::GamesController < ApplicationController
	def create
		# WE assume we will send quest_id, if we send user_id we can update
		quest = Quest.where('user_id = ?, status = ?', params[:user_id], :in_progress)
		user_id = params[:user_id]
		@fen = ChessQuestFacade.get_fen(params[:find_player])
		game = Game.create!(starting_fen: @fen, quest: quest)

		render json: GameSerializer.new(game), status: :created
	end
end
