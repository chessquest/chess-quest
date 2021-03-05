require 'rubygems'
require 'api_cache'

class GameService
	class << self

		def get_game_data(params)
			response = APICache.get(conn.build_url.to_s + "game?find_player=#{params}", {timeout: 30})
			parse(response)
		end

		private

		def conn
			Faraday.new("https://chess-com-api.herokuapp.com/api/v1/")
		end

		def parse(response)
			JSON.parse(response, symbolize_names: true)
		end
	end
end
