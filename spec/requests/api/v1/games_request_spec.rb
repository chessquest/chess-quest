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

        # creates extra games and verifies through the count that these are not included in the index for the current quest.
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
    end

    describe "sad path" do

    end
  end

  describe 'games update' do
    describe 'happy path' do
      it 'Updates the game with 201 response' do
        user_id = 1
        current_quest = Quest.new(user_id: user_id)
        game = Game.create(quest: current_quest, status: :in_progress, starting_fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

        parameters = {status: :won, current_fen: "rnbqkbnr/pppppppp/8/8/8/8/8/4K3 w kq - 2 39"}
        patch "/api/v1/users/#{user_id}/quests/#{current_quest.id}/games/#{game.id}", params: parameters
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        updated_game = Game.find(game.id)


        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(updated_game.status).to eq(parameters[:status].to_s)
        expect(updated_game.current_fen).to eq(parameters[:current_fen])

        expect(parsed_response[:data][:id]).to eq(game.id.to_s)
        expect(parsed_response[:data][:attributes][:status]).to eq(parameters[:status].to_s)
        expect(parsed_response[:data][:attributes][:current_fen]).to eq(parameters[:current_fen])
      end
    end

    describe "sad path" do

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
  end

    # describe 'sad path' do
    # end

  describe "find game" do 
    describe "happy path" do 
      it 'finds a game', :vcr do
        fen1 = 'r4bk1/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -'
        fen2 = 'r4bk2/1qp4P/p2p1Q2/1p1P4/5P2/4rN2/PPP5/2KR3R b - -'
        user_id = 1

        quest = Quest.create!(user_id: user_id)
        game1 = Game.create!(quest_id: quest.id, starting_fen: fen1)
        game2 = Game.create!(quest_id: quest.id, starting_fen: fen2)

        get "/api/v1/users/#{user_id}/games/#{game1.id}"

        expect(response).to be_successful
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data][:attributes][:status]).to eq(game1.status)
        expect(parsed_response[:data][:attributes][:status]).to eq('in_progress')
        expect(parsed_response[:data][:attributes][:starting_fen]).to eq(game1.starting_fen)

        expect(parsed_response[:data][:relationships]).to be_a Hash
        expect(parsed_response[:data][:relationships]).to have_key :quest
        expect(parsed_response[:data][:relationships][:quest]).to have_key :data
        expect(parsed_response[:data][:relationships][:quest][:data]).to have_key :id
        expect(parsed_response[:data][:relationships][:quest][:data][:id]).to be_a String
        expect(parsed_response[:data][:relationships][:quest][:data]).to have_key :type
        expect(parsed_response[:data][:relationships][:quest][:data][:type]).to eq("quest")
      end
    end
  end
end
