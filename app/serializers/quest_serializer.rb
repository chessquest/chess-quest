class QuestSerializer
	include FastJsonapi::ObjectSerializer
	attributes :status, :user_id
end