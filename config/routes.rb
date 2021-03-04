Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
	  namespace :v1 do
      get '/top_quests', to: 'stats#top_quests'

			resources :users, only: :show do
        get '/win_streak', to: 'stats#game_streak'
				resources :quests, only: %i[index create show update] do
          resources :games, only: %i[index update]
        end
				resources :games, only: %i[index create show]
			end
	  end
  end
end
