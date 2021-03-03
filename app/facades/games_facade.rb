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
			if params[:find_player] == "playclassic"
				fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
			else
				fen = get_fen(params[:find_player])
			end
			fen_poro = Fen.new(fen)
			fen_poro.to_starting_position
			Game.create!(starting_fen: fen_poro.fen, quest: quest)
		end

		def update_game(params)
			next_game(params) if (params[:status] == 1)
			end_quest(params) if (params[:status] == 2)
			game = Game.find(params[:id])
			game.current_fen = params[:current_fen]
			game.status = params[:status].to_i
			game
		end

		def get_fen(params)
			chess_game = GameService.get_game_data(params)
			chess_game[:data][:attributes][:fen]
		end

		private

		def next_game(params)
			fen_poro = Fen.new(params[:current_fen])
			fen_poro.to_starting_position
			quest = Quest.where(id: params[:quest_id]).where(status: 0).first
			Game.create(starting_fen: fen_poro.fen, quest: quest)
		end

		def end_quest(params)
			quest = Quest.where(id: params[:quest_id]).where(status: 0).first
			quest.update(status: 1)
		end
	end
end
