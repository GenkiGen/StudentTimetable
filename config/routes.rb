Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Sign up path
  get '/signup', to: 'students#new', as: :signup
  post '/signup', to: 'students#create', as: nil
  # Confirmation path
  resources :account_activation, only: [:edit]
end
