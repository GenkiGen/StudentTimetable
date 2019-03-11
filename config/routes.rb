Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Static pages
  get '/home', to: 'statics#home', as: :root
  # Sign up path
  get '/signup', to: 'students#new', as: :signup
  post '/signup', to: 'students#create', as: nil
  # Login path
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: nil
  # Confirmation path
  resources :account_activation, only: [:edit]
  # User path
  get '/students/:id', to: 'students#show', as: :student
end
