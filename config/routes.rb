Rails.application.routes.draw do
  # get 'posts/index'
  # get 'posts/show'
  # get 'users/index'
  # get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/users',                     to: 'users#index'
  get '/users/:id',                 to: 'users#show'
  get '/users/:user_id/posts',      to: 'posts#index'
  get '/users/:user_id/posts/:id',  to: 'posts#show'

  # Defines the root path route ("/")
  root "users#index"
end
