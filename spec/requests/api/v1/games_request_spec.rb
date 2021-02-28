require 'rails_helper'

RSpec.describe 'Games API' do
  describe 'games create' do
    describe 'happy path' do
      it 'creates a game', :vcr do
        user_id = 1

        current_quest = Quest.create!(user_id: user_id)

				game_params = {find_player: "magnuscarlsen"}
				headers = {'CONTENT_TYPE' => 'application/json'}
				post "/api/v1/users/#{user_id}/games", headers: headers, params: JSON.generate(game_params)

        created_game = Game.last

        expect(response).to be_successful

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(201)
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data][:attributes][:status]).to eq(created_game.status)
        expect(parsed_response[:data][:attributes][:status]).to eq('in_progress')
        expect(parsed_response[:data][:attributes][:starting_fen]).to eq(created_game.starting_fen)
        expect(parsed_response[:data][:attributes][:starting_fen]).to eq(created_game.current_fen)
      end
    end

    # describe 'sad path' do
    # end
  end
end
