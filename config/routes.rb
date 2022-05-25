Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'landing#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_auth'

  post '/users', to: 'users#create'

  get '/dashboard', to: 'users#show'
  get '/dashboard/discover', to: 'discover#index'
  get '/dashboard/movies', to: 'movies#index'
  get '/dashboard/movies/:id', to: 'movies#show'
  get '/dashboard/movies/:id/new', to: 'viewing_parties#new'
  post '/dashboard', to: 'viewing_parties#create'
end
