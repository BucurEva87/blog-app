Rails.application.routes.draw do
  # get 'likes/create'
  # get 'likes/destroy'
  # get 'comments/new'
  # get 'comments/create'
  # get 'posts/index'
  # get 'posts/show'
  # get 'users/index'
  # get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create, :destroy]
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
