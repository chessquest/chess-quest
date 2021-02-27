class Api::V1::QuestsController < ApplicationController
	def create
		user_id = params[:user_id]
		new_quest = Quest.create!(user_id: user_id)

		render json: QuestSerializer.new(new_quest), status: :created
	end

	def index
		quests = Quest.where(user_id: params[:user_id]).where(status: params[:status])

		render json: QuestSerializer.new(quests)
	end
end