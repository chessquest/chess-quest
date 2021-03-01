require 'rails_helper'

RSpec.describe 'Games API' do
  describe "games index", :vcr do
    describe "happy path" do
      it "returns a user's games that are associated with given quest" do
        user_id = 1
        num_games = 4
        current_quest = Quest.create(user_id: user_id)
        some_other_quest = Quest.create(user_id: user_id)

        games = (0..num_games-1).map do |i|
          Game.create(quest: current_quest, status: [:in_progress, :won, :lost].sample, starting_fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
        end

        # creates extra games and verifies through the count that these are not included in the index for the other quest.
        other_quest_games = (0..5).map do |i|
          Game.create(quest: some_other_quest, status: [:in_progress, :won, :lost].sample, starting_fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
        end

        get "/api/v1/users/#{user_id}/quests/#{current_quest.id}/games"
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(parsed_response[:data].count).to eq(num_games)

        num_games.times do |i|
          game = games[i]
          expect(parsed_response[:data][i][:id].to_i).to eq(game.id)
          expect(parsed_response[:data][i][:attributes][:status]).to eq(game.status)
          expect(parsed_response[:data][i][:attributes][:starting_fen]).to eq(game.starting_fen)
        end
      end

      describe "sad path" do

      end
    end

  end

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
