require 'rails_helper'

RSpec.describe 'Games API' do
  describe 'games create' do
    describe 'happy path' do
      it 'creates a game' do
        user_id = 1
        json_response = File.read("spec/fixtures/game.json")
        stub_request(:get, "https://chess-com-api.herokuapp.com/api/v1/game?find_player=magnus").
          to_return(status: 200, body: json_response)

        current_quest = Quest.create!(user_id: user_id)

				game_params = {name: "magnus", quest_id: current_quest.id}
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

    describe 'sad path' do
      it "microservice doesn't send us any data" do
        user_id = 1
        json_response = File.read("spec/fixtures/missing_fen.json")
        stub_request(:get, "https://chess-com-api.herokuapp.com/api/v1/game?find_player").
          to_return(status: 404, body: json_response)

        current_quest = Quest.create!(user_id: user_id)

        game_params = {find_player: "magnus", quest_id: current_quest.id}
        headers = {'CONTENT_TYPE' => 'application/json'}
        post "/api/v1/users/#{user_id}/games", headers: headers, params: JSON.generate(game_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

      end
    end
  end
end
