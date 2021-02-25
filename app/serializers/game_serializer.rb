class GameSerializer
	include FastJsonapi::ObjectSerializer
	attributes :status, :fen
end