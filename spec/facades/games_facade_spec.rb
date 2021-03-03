require 'rails_helper'

describe GamesFacade do
	describe "happy path" do
		it 'gets a game fen', :vcr do
			user_id = 1

			fen = GamesFacade.get_fen("magnuscarlsen")

			expect(fen).to be_an String
			expect(fen).to eq("r4bk1/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -")
		end

		it 'can find a game', :vcr do
			fen1 = 'r4bk1/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -'
			fen2 = 'r4bk2/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -'

			quest = Quest.create!(user_id: 1)
			game1 = Game.create!(quest_id: quest.id, starting_fen: fen1)
			game2 = Game.create!(quest_id: quest.id, starting_fen: fen2)

			params = game1.id
			game = GamesFacade.find_game(params)

			expect(game.id).to eq(game1.id)
			expect(game.starting_fen).to eq(game1.starting_fen)
			expect(game.id).to_not eq(game2.id)
			expect(game.starting_fen).to_not eq(game2.starting_fen)
		end
		it 'can create a classical game' do
			params = Hash.new
			params[:find_player] = "playclassic"
			quest = Quest.create!(user_id: 1)
			params[:user_id] = 1
			game = GamesFacade.create_game(params)

			expect(game.starting_fen).to eq("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
		end
		it 'can create a new game after a game is won' do
			fen1 = 'r4bk1/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -'

			quest = Quest.create!(user_id: 1)
			game1 = Game.create!(quest_id: quest.id, starting_fen: fen1)
			
			params = {}
			params[:id] = game1.id
			params[:quest_id] = quest.id
			params[:current_fen] = game1.current_fen
			params[:status] = 1

			GamesFacade.update_game(params)

			game = Game.last
			expect(game.starting_fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RN1QK2R w KQkq - 0 1')
			expect(game.status).to eq('in_progress')
		end
		it 'can end a quest if the game is lost' do
			fen1 = 'r4bk1/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -'

			quest = Quest.create!(user_id: 1)
			game1 = Game.create!(quest_id: quest.id, starting_fen: fen1)
			
			params = {}
			params[:id] = game1.id
			params[:quest_id] = quest.id
			params[:current_fen] = game1.current_fen
			params[:status] = 2

			GamesFacade.update_game(params)

			expect(Quest.last.status).to eq('completed')
		end
	end
end
