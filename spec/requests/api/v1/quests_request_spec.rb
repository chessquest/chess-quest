require 'rails_helper'

RSpec.describe 'Quests API' do
  describe 'quest create' do
    describe 'happy path' do
      it 'creates a quest' do
        user_id = 2
        quest_params = {user_id: user_id}
				headers = {'CONTENT_TYPE' => 'application/json'}
				post "/api/v1/users/#{user_id}/quests", headers: headers, params: JSON.generate(quest_params)

        created_quest = Quest.last
        expect(response).to be_successful
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data][:attributes][:status]).to eq(created_quest.status)
        expect(parsed_response[:data][:attributes][:status]).to eq('in_progress')
        expect(parsed_response[:data][:attributes][:user_id]).to eq(created_quest.user_id)

      end

      it "can convert quest to JSON and send upon creation" do
      end
    end

    describe 'sad path' do
      it "i dunno <3" do
        
      end
    end
  end

  describe 'Quests index' do
    describe 'happy path' do
      # TODO: Test for multiple quests, that have been completed
      it 'can return a current_quest' do
        user_id = 2
        quest_params = {status: 'in_progress'}
				headers = {'CONTENT_TYPE' => 'application/json'}
        quest = Quest.create!(user_id: user_id)
				get "/api/v1/users/#{user_id}/quests", headers: headers, params: (quest_params)

        expect(response).to be_successful
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data].first[:attributes][:status]).to eq(quest.status)
        expect(parsed_response[:data].first[:attributes][:status]).to eq('in_progress')
        expect(parsed_response[:data].first[:attributes][:user_id]).to eq(quest.user_id)
      end

      it 'can return a quest with its games' do
        user_id = 2
        quest_params = {status: 'in_progress'}
        headers = {'CONTENT_TYPE' => 'application/json'}
        quest = Quest.create!(user_id: user_id)
        quest.games.create!(status: 'in_progress', starting_fen: 'fen!', current_fen: 'fen!!')

        get "/api/v1/users/#{user_id}/quests", headers: headers, params: (quest_params)
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(parsed_response).to be_a Hash

        expect(parsed_response[:included]).to be_an Array
        expect(parsed_response[:included][0]).to be_a Hash
        expect(parsed_response[:included][0][:type]).to eq('game')
        expect(parsed_response[:included][0][:attributes]).to be_a Hash
        expect(parsed_response[:included][0][:attributes]).to have_key :status
        expect(parsed_response[:included][0][:attributes]).to have_key :starting_fen
        expect(parsed_response[:included][0][:attributes]).to have_key :current_fen
      end
    end

    describe "sad path" do
    end
  end

  describe "Quest show" do
    describe "happy path" do
      it 'I can return a single quest' do
        quest = Quest.create!(user_id: 2)

        get "/api/v1/users/#{quest.user_id}/quests/#{quest.id}"

        expect(response).to be_successful

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data][:attributes][:status]).to eq(quest.status)
        expect(parsed_response[:data][:attributes][:status]).to eq('in_progress')
        expect(parsed_response[:data][:attributes][:user_id]).to eq(quest.user_id)
      end
    end

    describe "sad path" do
      it 'returns status 404 if user does not exist' do
        quest = Quest.create!(user_id: 2)

        get "/api/v1/users/#{quest.user_id}/quests/12"

        expect(response.status).to eq(404)
      end
    end
  end

  describe "Quest Update" do
    describe "happy path" do
      it 'I can update a quest successfully' do
	      quest = Quest.create!(user_id: 2)
        quest_params = {status: "completed"}
        headers = {'CONTENT_TYPE' => 'application/json'}

        expect(quest.status).to eq("in_progress")

        patch "/api/v1/users/#{quest.user_id}/quests/#{quest.id}", headers: headers, params: JSON.generate(quest_params)


	      updated_quest = Quest.last

        expect(response).to be_successful
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:data][:attributes][:status]).to eq(updated_quest.status)
        expect(parsed_response[:data][:attributes][:status]).to eq('completed')
        expect(parsed_response[:data][:attributes][:user_id]).to eq(updated_quest.user_id)
      end
    end

    describe "sad path" do
      it 'it returns 404 if quest does not exist' do
        quest = Quest.create!(user_id: 2)

        get "/api/v1/users/#{quest.user_id}/quests/123"

        expect(response.status).to eq(404)
      end
    end
  end
end