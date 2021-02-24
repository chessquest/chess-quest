class Quest < ApplicationRecord
	has_many :games

	validates_presence_of :user_id
	validates_presence_of :status

	enum [:in_progress, :completed]
end
