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
		fen = GameFacade.get_fen(params[:find_player])
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

	def update
		# could define game_params here as a refactor, but only 2 things will realistically be changing
		game = Game.find(params[:id])
		game.current_fen = params[:current_fen]
		game.status = params[:status]
		if game.save
			render json: GameSerializer.new(game)
		else
			# sad path goes here
		end
	end
end
