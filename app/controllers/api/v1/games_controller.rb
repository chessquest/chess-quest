class Api::V1::GamesController < ApplicationController
	def show
		game = GamesFacade.find_game(params[:id])
		render json: GameSerializer.new(game)
	end

	def create
		game = GamesFacade.create_game(params)
		render json: GameSerializer.new(game), status: :created
	end

	def index
		games = GamesFacade.quest_games(params)
		render json: GameSerializer.new(games)
	end

	def update
		game = GamesFacade.update_game(params)
		if game.save
			render json: GameSerializer.new(game)
		else
			# sad path goes here
		end
	end
end
