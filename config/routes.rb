Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Trying to do this without any resource: atg
  get '/signup', to: 'student#new', as: :signup
  post '/signup', to: 'student#create', as: nil
end
