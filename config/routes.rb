Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  root to: "users#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
