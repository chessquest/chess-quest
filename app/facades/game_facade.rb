class GameFacade
	class << self
		# MAKE BROADER THAN JUST FEN IF WE NEED MORE DATA DOWN THE LINE
		def get_fen(params)
			chess_game = GameService.get_game_data(params)
			chess_game[:data][:attributes][:fen]
		end	
	end
end