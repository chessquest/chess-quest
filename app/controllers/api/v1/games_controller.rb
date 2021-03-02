class Api::V1::GamesController < ApplicationController
	def show
		render json: GameSerializer.new(
			Game.find(params[:id])
		)
	end

	def create
		game = GameFacade.create_game(params)
		render json: GameSerializer.new(game), status: :created
	end

	def index
		games = GameFacade.quest_games(params)
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
