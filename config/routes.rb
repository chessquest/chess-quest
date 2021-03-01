Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
	  namespace :v1 do
			resources :users, only: :show do
				resources :quests, only: %i[index create show update] do
          get "/games", to: "games#index"
        end
				resources :games, only: %i[index create show]
			end

		  namespace :users do
			  get '/:id/win_streak', to: 'stats#win_streak'
			  get '/:id/win_loss', to: 'stats#win_loss'
			  get '/:id/pieces', to: 'stats#pieces'
			  get '/:id/total_quests', to: 'stats#total_quests'
		  end
	  end
  end
end
