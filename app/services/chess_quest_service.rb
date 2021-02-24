class ChessQuestService
	class << self

		def get_fen(params)
			response = conn.get("game") do |req|
				req.params[:find] = params
			end
			parse(response)
		end

		private

		def conn
			Faraday.new("https://https://chess-com-api.herokuapp.com/api/v1/")
		end

		def parse(response)
			JSON.parse(response.body, symbolize_names: true)
		end

	end
end