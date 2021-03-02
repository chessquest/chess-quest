require 'rails_helper'

describe GameFacade do
	describe "happy path" do
		it 'gets a game', :vcr do
			user_id = 1

			fen = GameFacade.get_fen("magnuscarlsen")

			expect(fen).to be_an String
			expect(fen).to eq("r4bk1/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -")
		end
	end
end
