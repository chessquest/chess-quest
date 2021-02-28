require 'rails_helper'

describe GameService do
	describe "class methods" do
		describe "::get_fen" do
			it 'gets a game', :vcr do
				game = GameService.get_game_data("magnuscarlsen")

				expect(game).to be_a Hash
				expect(game).to have_key(:data)
				expect(game[:data]).to be_a Hash
				expect(game[:data]).to have_key(:attributes)
			end
		end
	end
end
