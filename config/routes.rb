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
  get '/learners', to: 'learners#index', as: :learners
  # Teacher path
  get '/teachers/:id', to: 'teachers#show', as: :teacher
  get '/teachers', to: 'teachers#index', as: :teachers
  # Courses path
  get '/courses/create', to: 'courses#new', as: :create_course
  post '/courses/create', to: 'courses#create', as: nil
  # Course search path
  get '/courses/search', to: 'courses#search', as: :search_course
  get '/courses', to: 'courses#index', as: :courses
  patch '/courses/:id/follow', to: 'courses#follow', as: :follow_course
  delete '/courses/:id/follow', to: 'courses#unfollow', as: nil
  get '/courses/:id', to: 'courses#show', as: :course
  delete '/courses/:id', to: 'courses#delete', as: nil
  # Schedule path
  get '/courses/:id/schedules/create', to: 'schedules#new', as: :create_schedule
  post '/courses/:id/schedules/create', to: 'schedules#create', as: nil
end
