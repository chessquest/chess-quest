class GameSerializer
	include FastJsonapi::ObjectSerializer
	attributes :status, :starting_fen, :current_fen
end
