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
    end
    describe "sad path" do
	    
    end
  end

  describe "Quest show" do
    describe "happy path" do
      it 'I can return a single quest' do
        quest = Quest.create!(user_id: 2)
        quest2 = Quest.create!(user_id: 3)

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
        quest2 = Quest.create!(user_id: 3)

        get "/api/v1/users/#{quest.id}/quests/12"

        expect(response.status).to eq(404)
      end
    end
  end
end