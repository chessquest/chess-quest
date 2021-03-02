class GameSerializer
	include FastJsonapi::ObjectSerializer
	attributes :status, :starting_fen, :current_fen
	belongs_to :quest
end
