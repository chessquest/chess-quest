class Quest < ApplicationRecord
	has_many :games

	validates_presence_of :user_id
	validates_presence_of :status

	enum status: [in_progress: 0, completed: 1]
end
