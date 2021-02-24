class GamesController < ApplicationController
	def create
		@fen = ChessQuestFacade.get_fen(params[:game_board])
		game = Game.create(status: 0, fen: @fen)
	end
end