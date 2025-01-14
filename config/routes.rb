Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#landing', as: 'root'
  get '/register', to: 'users#new', as: 'new_user'
  get '/login', to: 'sessions#new', as: 'login_form'
  post '/login', to: 'sessions#create', as: 'login_user'
  delete '/logout', to: 'sessions#destroy'
  get '/users/movies/:id', to: 'movies#show'
  get '/dashboard', to: 'users#show'
  post '/movies/:id/viewing_party/new', to: 'viewing_party#create'
  resources :discover, only: [:index]
  resources :movies, only: [:index, :show] do
    resources :viewing_party, only: [:new, :create]
  end
  resources :users, only: [:create]
end
