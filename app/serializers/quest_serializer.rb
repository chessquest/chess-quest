class QuestSerializer
	include FastJsonapi::ObjectSerializer
	attributes :status, :user_id
	has_many :games
end
