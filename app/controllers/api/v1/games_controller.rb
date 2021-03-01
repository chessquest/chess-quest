class Api::V1::GamesController < ApplicationController
	def show
		render json: GameSerializer.new(
			Game.find(params[:id])
		)
	end

	def create
		# WE assume we will send quest_id, if we send user_id we can update
		quest = Quest.where('user_id = ? AND status = ?', params[:user_id], 0).first
		user_id = params[:user_id]
		fen = ChessQuestFacade.get_fen(params[:find_player])
		fen_poro = Fen.new(fen)
		fen_poro.to_starting_position
		game = Game.create!(starting_fen: fen_poro.fen, quest: quest)

		render json: GameSerializer.new(game), status: :created
	end

	def index
		quest = Quest.find(params[:quest_id])
		games = quest.games
		render json: GameSerializer.new(games)
	end
end
