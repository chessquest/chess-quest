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
        expected_response = {:data=>{:type=>"user_stats", :attributes=>{:quest_id=>quest.id, :streak=>num_games}}}

        expect(parsed_response).to eq(expected_response)
      end
    end
  end
end
