class GamesController < ApplicationController
	def create
		@fen = ChessQuestFacade.get_fen(params[:name])
		game = Game.create(status: 0, fen: @fen)
	end
end