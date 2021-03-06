class Api::V1::QuestsController < ApplicationController
	def create
		user_id = params[:user_id]
		new_quest = Quest.create!(user_id: user_id)

		render json: QuestSerializer.new(new_quest), status: :created
	end

	def index
		params[:status] ?
			quests = Quest.where(user_id: params[:user_id]).where(status: params[:status]) :
			quests = Quest.where(user_id: params[:user_id])
		render json: QuestSerializer.new(quests, { include: [:games] })
	end

	def show
		quest = Quest.find(params[:id])
		render json: QuestSerializer.new(quest, { include: [:games] })
	end

	def update
		quest = Quest.find(params[:id])
		quest.update!(status: params[:status])
		render json: QuestSerializer.new(quest, { include: [:games] })
	end
end
