Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Static pages
  get '/home', to: 'statics#home', as: :root
  # Sign up path
  get '/learners/signup', to: 'learners#new', as: :learner_signup
  post '/learners/signup', to: 'learners#create', as: nil
  get '/teachers/signup', to: 'teachers#new', as: :teacher_signup
  post '/teachers/signup', to: 'teachers#create', as: nil
  # Login path
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: nil
  delete '/logout', to: 'sessions#delete', as: :logout
  # Confirmation path
  resources :account_activation, only: [:edit]
  # User path
  get '/users/:id', to: 'users#show', as: :user
  # Learner path
  get '/learners/:id', to: 'learners#show', as: :learner
  # Teacher path
  get '/teachers/:id', to: 'teachers#show', as: :teacher
  # Courses path
  get '/courses/create', to: 'courses#new', as: :create_course
  post '/courses/create', to: 'courses#create', as: nil
  get '/courses', to: 'courses#index', as: :courses
  patch '/courses/:id/follow', to: 'courses#follow', as: :follow_course
  delete '/courses/:id/follow', to: 'courses#unfollow', as: nil
  delete '/courses/:id', to: 'courses#delete', as: :course
end
