Tictacappv1::Application.routes.draw do

  resources :users
  resources :games do
    member do
      post "make_move/:square", to: "games#make_move", as: "make_move"

    end
  end

#for this game make a move e.g. the lesson -acts_as_lists
#have a route then look for action

  get '/home', to: 'home#home'
  get '/high_scores/', to: 'users#high_scores', as: 'high_scores'

  root to: "home#home"
  get 'login', to: 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]


end
