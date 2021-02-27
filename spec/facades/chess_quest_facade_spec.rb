require 'rails_helper'

describe ChessQuestFacade do
	describe "happy path" do
		it 'gets a game' do
			user_id = 1
			json_response = File.read("spec/fixtures/game.json")
			stub_request(:get, "https://chess-com-api.herokuapp.com/api/v1/game?find=magnus").
				to_return(status: 200, body: json_response)

			fen = ChessQuestFacade.get_fen("magnus")

			expect(fen).to be_an String
			expect(fen).to eq("this_is_the_fen_string")
		end
	end
end