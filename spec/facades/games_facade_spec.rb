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
	end
end
