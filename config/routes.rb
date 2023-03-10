Rails.application.routes.draw do
  devise_for :users
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
      resources :comments, only: [:index, :new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create] do
        resources :posts, only: %i[index show create] do
          resources :comments, only: %i[index show create]
        end
      end
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
