require "rails_helper"

describe "Stats endpoint" do
  describe "game streak" do
    describe "happy path" do
      it "can show how many games are associated with a user's current quest" do
        user_id = 1
        num_games = 5

        past_quest = Quest.create(status: :completed, user_id: user_id)
        past_games = (0..6).map do |i|
          Game.create(quest: past_quest, status: :lost, starting_fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
        end

        quest = Quest.create(status: :in_progress, user_id: user_id)
        games = (0..num_games-1).map do |i|
          quest.games.create(status: :won, starting_fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
        end
        quest.games.create(status: :in_progress, starting_fen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

        get "/api/v1/users/#{user_id}/win_streak"
        expect(response).to be_successful
        expect(response.status).to eq(200)

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:data][:type]).to eq("user_stat")
        expect(parsed_response[:data][:attributes][:quest_id]).to eq(quest.id)
        expect(parsed_response[:data][:attributes][:streak]).to eq(num_games)

      end
    end

    describe "top games" do
      describe "happy path" do
        it "can return the top 3 game streaks" do
          default_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

          user_1_id = 1
          user_2_id = 2
          user_3_id = 3
          user_4_id = 4

          user_1_num_games = 5
          user_1_num_games_2 = 10
          user_2_num_games = 7
          user_3_num_games = 1
          user_4_num_games = 3

          user_1_quest_1 = Quest.create(status: :completed, user_id: user_1_id)
          user_1_num_games.times do
            user_1_quest_1.games.create(status: :won, starting_fen: default_fen)
          end

          user_1_quest_2 = Quest.create(status: :in_progress, user_id: user_1_id)
          user_1_num_games_2.times do
            user_1_quest_2.games.create(status: :won, starting_fen: default_fen)
          end

          user_2_quest = Quest.create(status: :in_progress, user_id: user_2_id)
          user_2_num_games.times do
            user_2_quest.games.create(status: :won, starting_fen: default_fen)
          end

          user_3_quest = Quest.create(status: :in_progress, user_id: user_3_id)
          user_3_num_games.times do
            user_3_quest.games.create(status: :won, starting_fen: default_fen)
          end

          user_4_quest = Quest.create(status: :in_progress, user_id: user_4_id)
          user_4_num_games.times do
            user_4_quest.games.create(status: :won, starting_fen: default_fen)
          end

          get "/api/v1/top_quests"

          parsed_response = JSON.parse(response.body, symbolize_names: true)

          expect(response).to be_successful
          expect(response.status).to eq(200)


          expect(parsed_response[:data][0][:type]).to eq("quest_stat")

          expect(parsed_response[:data][0][:attributes][:user_id]).to eq(user_1_id)
          expect(parsed_response[:data][0][:attributes][:streak]).to eq(user_1_num_games_2)

          expect(parsed_response[:data][1][:attributes][:user_id]).to eq(user_2_id)
          expect(parsed_response[:data][1][:attributes][:streak]).to eq(user_2_num_games)

          expect(parsed_response[:data][2][:attributes][:user_id]).to eq(user_1_id)
          expect(parsed_response[:data][2][:attributes][:streak]).to eq(user_1_num_games)
        end
      end
    end
  end
end
