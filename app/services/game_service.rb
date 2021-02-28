class GameService
	class << self

		def get_game_data(params)
			response = conn.get("game") do |req|
				req.params[:find_player] = params
			end
			parse(response)
		end

		private

		def conn
			Faraday.new("https://chess-com-api.herokuapp.com/api/v1/")
		end

		def parse(response)
			JSON.parse(response.body, symbolize_names: true)
		end
	end
end