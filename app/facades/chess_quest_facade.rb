class ChessQuestFacade
	class << self

		def get_fen(params)
			chess_game = ChessQuestService.get_fen(params)
			chess_game[:data][:attributes][:fen]
		end

	end
end