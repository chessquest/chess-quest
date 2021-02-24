require 'rails_helper'

describe GameService do
	describe "class methods" do
		describe "::get_fen" do
			it 'gets a game ' do
				json_response = File.read("spec/fixtures/game.json")
				stub_request(:get, "https://https://chess-com-api.herokuapp.com/api/v1/game?find=magnus").
					to_return(status: 200, body: json_response)

				game = GameService.get_game_data("magnus")

				expect(game).to be_a Hash
				expect(game).to have_key(:data)
				expect(game[:data]).to be_a Hash
				expect(game[:data]).to have_key(:attributes)
				expect(game[:data][:attributes][:fen]).to eq("this_is_the_fen_string")
			end
		end
	end
end