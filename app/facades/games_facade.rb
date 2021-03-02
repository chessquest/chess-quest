class GamesFacade
	class << self
		# MAKE BROADER THAN JUST FEN IF WE NEED MORE DATA DOWN THE LINE
		def quest_games(params)
			quest = Quest.find(params[:quest_id])
			quest.games	
		end

		def find_game(params)
			Game.find(params.to_i)
		end
		
		def create_game(params)
			quest = Quest.where('user_id = ? AND status = ?', params[:user_id], 0).first
			fen = get_fen(params[:find_player])
			fen_poro = Fen.new(fen)
			fen_poro.to_starting_position
			Game.create!(starting_fen: fen_poro.fen, quest: quest)	
		end

		def update_game(params)
			game = Game.find(params[:id])
			game.current_fen = params[:current_fen]
			game.status = params[:status]	
			game
		end
		
		def get_fen(params)	
			chess_game = GameService.get_game_data(params)
			chess_game[:data][:attributes][:fen]
		end	
	end
end